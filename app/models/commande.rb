class Commande < ActiveRecord::Base
	#################################################
	# Les commandes réalisées par les users.
	######## => #########################################

	belongs_to :pack
	belongs_to :glisse
	belongs_to :tbk
	belongs_to :personne
	belongs_to :event
	has_many :products, through: :commande_products
        accepts_nested_attributes_for :products, :allow_destroy => true

        has_many :product_personne_preferences
        accepts_nested_attributes_for :product_personne_preferences, :allow_destroy => true

	has_many :commande_products, dependent: :destroy        

	has_many :paiements
        

	#attr_accessible :assurance, :status

	attr_accessor :missings
	attr_accessor :warnings

	validates :tbk, :presence => true
	validates :personne, :presence => true
	validates :event, :presence => true
	validates :event, uniqueness: { scope: :personne, message: "Une seule commande par evenement par personne" }
#        validates :products, :presence => true
        

	def ok?
		return false
	end

        def reject_nested(attributes)
          exists = attributes['id'].present?
          empty = attributes.slice(:when, :where).values.all?(&:blank?)
          attributes.merge!({:_destroy => 1}) if exists and empty
          return (!exists and empty)
        end

	#Ajoute un produit à la commande en précisant le nombre de produits
	def add_product (product, nbr = 1, options = Hash.new)
		
		product= Product.find(product)
		can_add=true
		unless options[:force] 
			cat=product.categorie

			cp = self.commande_products.find_by(product_id: product)

			if product.max_par_personne
				nombre = cp && cp.nombre || 0
				can_add = false unless nombre < product.max_par_personne
			end
			if cat.max_par_personne
				nombre_cat = self.commande_products.select{|cp| cp.product.categorie_id == cat.id}.map{|cp| cp.nombre}.sum
				can_add = false unless nombre_cat < cat.max_par_personne
			end
		end

		

		if can_add
			if product.event_id == self.event_id
				cp||=self.commande_products.find_or_create_by(product_id: product.id)
				if cp.nombre
					cp.nombre += nbr
				else
					cp.nombre = nbr
				end
				cp.save
			else
				false
			end
		end
	end

	#enleve un produit à la commande en précisant le nombre de produits
	def remove_product (product, nbr = 1)
		if (cp=self.commande_products.find_by_product_id(product.id))
			if cp.nombre > nbr
				cp.nombre -= nbr
				cp.save
			else
				cp.delete
			end
		else
			false
		end		
	end

	##### Vérification du statut d'une commande
 	# complete? => true si:
 	# total à payer =  total des paiement ET
 	# (la personne à une assurance ET a donné un justificatif) OU a dans sa commande un produit assurance
	def complete?

		# ne revoie rie net quitte si la commande n'appartient à personne
		return nil if self.personne.nil?


		self.missings = []

		#Verification du paiemente
		du=self.montant_du
		paye=self.montant_paye
		self.missings << "Commande non payee entieremente. Reste : #{du-paye}" unless du <= paye unless self.bypasspaiement


		#Vérification de l'assurance
		## Avec proposition d'une RC dans les produits
		# produit_assurance=false

		# self.products.each{|p| produit_assurance = true if p.categorie_id == Configurable[:id_cat_assurance]}

		# unless produit_assurance || self.bypassassurance
		# 	if self.personne.assurance
		# 		self.missings << "Personne avec assurance personnelle mais pas de justificatif" unless self.personne.documentassurance
		# 	else
		# 		self.missings << "Personne non assuree"
		# 	end
		# end

		unless self.personne.documentassurance
			self.missings << "Commande sans caution"
		end

		# vérifie si une caution est donnée
		unless self.caution
			self.missings << "Commande sans caution"
		end

		unless self.nbr_pack>0
			self.missings << "Ne contient pas de pack"
		end

		if self.nbr_pack>1
			self.missings << "Contient plusieurs packs"
		end


		missings.blank?

	end
	
	def nbr_pack
		self.products.select{|p| p.categorie_id == Configurable[:id_pack]}.count
	end

	#Montant total de la commande (Produits * quantités)
	def montant_total
		self.commande_products.where(en_attente: false).map{|cp| cp.nombre.to_i * cp.product.price}.sum
	end

	#Montant déjà payé (Somme des paiements)
	def montant_paye
		self.paiements.where(verif: true).map{|p| p.amount_cents.to_i}.sum
	end

	def montant_du
		montant_total - montant_paye
	end

	def montant_du_euro
		montant_du / 100.0
	end

	def montant_pack
		self.products.where(categorie_id: Configurable[:id_pack]).map{|p| p.price}.sum
	end

	def paiementok?
		montant_du == 0  && montant_paye > 0
	end
	def paiement_etape
		# case montant_paye
		# when 0
			
		# when montant_pack / 2
		# 	# premier paiement réalisé
		# 	return 1
		# when montant_pack
		# 	# second paiment réalisé
		# 	return 2
		# when montant_total
		# 	# 3eme paiement réalisé
		# 	return 3
		# end
		if montant_pack>0
			if montant_paye >= montant_total
				# 3eme paiement réalisé
				return 3			
			elsif montant_paye >= montant_pack
				# second paiment réalisé
				return 2
			elsif montant_paye >= montant_pack / 2 
				# premier paiement réalisé
				return 1
			else
				#aucun paiement
			return 0
			end
		else
			return 0 
		end
	end

	def etape_valide? (etape)
		paiement_etape >= etape
	end

	def prochain_paiement
		p = self.paiement_etape
		case p
		when 0
			montant_pack.to_i / 2
		when 1
			montant_pack.to_i - montant_paye
		when 2
			montant_du
		when 3
			0
		end		 	 
	end

	def gen_idlong
		(SecureRandom.random_number *10**14).to_s[0,13]
	end

	def gen_ean13
		# head 		1
		# event 	1
		# personne 	4
		# commande 	4
		# random 	2

		return nil if self.personne.nil?
		head = 2.to_s
		event = self.event_id[0.1].to_s # attention,l'event id doit etre à 1 chiffre
		personneid = self.personne.id.to_s
		personneid = "0"+personneid while personneid.length < 4 #on complete pour avoir toujours 4 chiffres dans le numero de commande
		commandeid = self.id.to_s
		commandeid = "0"+commandeid while commandeid.length < 4 #on complete pour avoir toujours 4 chiffres dans le numero de commande
		rdm=(SecureRandom.random_number *10**14).to_s[0,2].to_s

		ean_s= head + event + personneid + commandeid + rdm
		EAN13.complete(ean_s)
	end

	def gen_and_record_ean13
		self.ean=self.gen_ean13
		self.save
		
	end

	def a_donne_caution
	self.caution=true
	self.caution_updated_at = DateTime.now
	self.save
	end

	def serialize
		pers = self.personne
		result = Hash.new
		result[:id]=self.id
		result[:idlong]=self.idlong
		result[:event]=self.event ? self.event.name : "EVENT NON RENSEIGNE"

		if pers
			result[:email]=pers.email
			result[:nom]=pers.nom
			result[:prenom]=pers.prenom
			result[:bucque]=pers.bucque
			result[:nums]=pers.fams
			result[:promo]=pers.promo
			result[:tel]=pers.phone
			result[:taille]=pers.taille
			result[:pointure]=pers.pointure
			result[:vetement]=pers.taillevetement.name if pers.taillevetement
			temp=pers.chambres.where(event_id: self.event_id).first
			result[:chambre]=temp.identifiant if temp
			result[:typeresid]=pers.typeresid.name if pers.typeresid.present?
			result[:lit]=pers.lit.name if pers.lit.present?
		end

		result[:tbk]=self.tbk ? self.tbk.nom_complet : "AUCUN"

		result[:paiement1]= self.etape_valide?(1.to_i) ? "OUI" : "NON"
		result[:paiement2]= self.etape_valide?(2.to_i) ? "OUI" : "NON"
		result[:paiement3]= self.paiementok? ? "OUI" : "NON"

		products= Hash.new
		Categorie.all.each do|c|
			if not(c.max_par_personne) || c.max_par_personne > 1
				c.products.each do |p|
					cp=self.commande_products.select{|cp| cp.product_id==p.id}.first
					products[p.name+"- semaine "+p.event_id.to_s]=cp ? cp.nombre : 0
				end
			else
				cp = self.commande_products.select{|cp| cp.product.categorie_id==c.id}.first
				products[c.nom]= cp ? cp.product.name : 0
			end
		end

		result[:products]=products
		result[:complete]= complete? ? "OUI" : "NON"

		return result
	end

	def check_in
		true
	end
end

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
	has_many :commande_products
	has_many :paiements

	#attr_accessible :assurance, :status

	attr_accessor :missings
	attr_accessor :warnings

	validates :tbk, :presence => true
	validates :personne, :presence => true
	validates :event, :presence => true
	validates :event, uniqueness: { scope: :personne, message: "Une seule commande par evenement par personne" }
	

	def ok?
		return false
	end

	#Ajoute un produit à la commande en précisant le nombre de produits
	def add_product (product, nbr = 1)
		if product.event_id == self.event_id
			cp=self.commande_products.find_or_create_by(product_id: product.id) 
			
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

		missings.blank?

	end


	#Montant total de la commande (Produits * quantités)
	def montant_total
		self.commande_products.map{|cp| cp.nombre.to_i * cp.product.price}.sum
	end

	#Montant déjà payé (Somme des paiements)
	def montant_paye
		self.paiements.map{|p| p.amount_cents.to_i}.sum
	end

	def montant_du
		montant_total - montant_paye
	end

	def montant_pack
		self.products.where(categorie_id: Configurable[:id_pack]).map{|p| p.price}.sum
	end

	def paiementok?
		montant_du == 0
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

		if montant_paye == 0
			#aucun paiement
			0
		elsif montant_paye == montant_total
			# 3eme paiement réalisé
			3			
		elsif montant_paye >= montant_pack
			# second paiment réalisé
			2
		elsif montant_paye >= montant_pack / 2
			# premier paiement réalisé
			1

		end
	end

	def prochain_paiement
		p = self.paiement_etape
		case p
		when 0
			montant_pack.to_i / 2
		when 1
			montant_pack.to_i / 2
		when 2
			montant_du
		when 3
			0
		end		 	 
	end

	def gen_idlong
		(SecureRandom.random_number *10**14).to_s[0,13]
	end

	def a_donne_caution
	self.caution=true
	self.save
	end
end

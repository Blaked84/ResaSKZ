class Commande < ActiveRecord::Base
	#################################################
	# Les commandes réalisées par les users.
	######## => #########################################

	has_one :pack
	belongs_to :glisse
	belongs_to :tbk
	belongs_to :personne
	has_many :products, through: :commande_products
	has_many :commande_products
	has_many :paiements

	#attr_accessible :assurance, :status

	attr_accessor :missings
	attr_accessor :warnings

	validate :personne, :presence => true
	
	def ok?
		return false
	end

	#Ajoute un produit à la commande en précisant le nombre de produits
	def add_product (product, nbr = 1)
		cp=self.commande_products.find_or_create_by(product_id: product.id) 
		
		if cp.nombre
			cp.nombre += nbr
		else
			cp.nombre = nbr
		end
		cp.save
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
		self.missings << "Commande non payee entieremente. Reste : #{du-paye}" unless du <= paye


		#Vérification de l'assurance

		produit_assurance=false

		self.products.each{|p| produit_assurance = true if p.categorie_id == Configurable[:id_cat_assurance]}

		unless produit_assurance
			if self.personne.assurance
				self.missings << "Personne avec assurance personnelle mais pas de justificatif" unless self.personne.documentassurance
			else
				self.missings << "Personne non assuree"
			end
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
		self.paiements.map{|p| p.amount_cents}.sum
	end

	def montant_du
		montant_total - montant_paye
	end
end

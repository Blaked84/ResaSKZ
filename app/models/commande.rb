class Commande < ActiveRecord::Base
	#################################################
	# Les commandes réalisées par les users.
	#################################################

	has_one :pack
	belongs_to :glisse
	belongs_to :tbk
	belongs_to :personne
	has_many :products, through: :commande_products
	has_many :commande_products
	has_many :paiements

	#attr_accessible :assurance, :status
	
	def ok?
		return false
	end

	#Ajoute un produit à la commande en précisant le nombre de produits
	def add_product (product, nbr = 1)
		self.commande_products.create(nombre: nbr, product_id: product.id)
	end
end

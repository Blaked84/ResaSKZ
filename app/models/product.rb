class Product < ActiveRecord::Base

	#################################################
	# Les produits commandable
	#################################################
	has_many :commandes, through: :commande_products
	has_many :commande_products
	has_many :pack
	has_one :categorie
	belongs_to :event

	#attr_accessible :name, :price, :stock, :echeance

	def to_s
		return self.nom
	end

	def to_str
		return self.nom
	end

	def price_euro
		return self.price / 100.0
	end
end
class Product < ActiveRecord::Base

	#################################################
	# Les produits commandable
	#################################################
	has_many :commandes, through: :commande_products
	has_many :commande_products, dependent: :destroy
	has_many :pack
	belongs_to :categorie
	belongs_to :event

	#attr_accessible :name, :price, :stock, :echeance

	def to_s
		return self.name
	end

	def to_str
		return self.name
	end

	def price_euro
		return self.price / 100.0
	end

	def restant
		return nil if self.stock == 0
		self.stock ||=0
		self.stock.to_i - self.commande_products.map{|cp| cp.nombre}.sum
	end

	def reste? (nbr = 0)

		return true if self.stock == 0 || self.stock.blank?

		self.restant > 0

	end

        def product_id
          return self.id
        end

        def oui
          return "Oui"
        end

end

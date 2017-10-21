class Product < ActiveRecord::Base

	#################################################
	# Les produits commandable
	#################################################
	has_many :commandes, through: :commande_products
	has_many :commande_products, dependent: :destroy
        has_many :product_personne_preferences

	has_many :pack
	belongs_to :categorie
	belongs_to :event
        belongs_to :gamme
        belongs_to :type_product
        belongs_to :option_sup

	#attr_accessible :name, :price, :stock, :echeance
        attr_accessor :couleur_cadre, :couleur_verre

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

        def restant_masque
          if self.option_sup_id != nil
            c_cadre = self.option_sup.couleur_cadre           
            cumul = 0
            OptionSup.where(couleur_cadre: c_cadre).each do |o|
              if o.products.first.commande_products.present?
                commandes= o.products.first.commande_products.map{|cp| cp.nombre}.sum
                cumul += commandes
              end
            end
            if self.stock.nil? or self.stock == 0
              return "infini"
            else
              return self.stock.to_i - cumul
            end
          end
        end

        def reste_masque?
   	  return true if self.stock == 0 || self.stock.nil?
          self.restant_masque > 0
        end

        def product_id
          return self.id
        end
        def anims_id
          return self.id
        end

        def oui
          return "Oui"
        end

        def name_gamme
          return self.gamme.nom + " - " + self.name
        end

        def self.preferences_form
          arr = []
          self.preferences.each do |p|
            if p == "1"
              arr << [p.to_s+" (1er choix)",p.to_i]
            elsif p == "2"
              arr << [p.to_s+" (2nd choix)",p.to_i]
            else
              arr << [p.to_s+" (3ème choix)",p.to_i]
            end
          end
          return arr
	end

        def self.preferences
          count = 3
          array = []
          (1..count).each do |i|
            array << i.to_s
          end
          return array
        end

end

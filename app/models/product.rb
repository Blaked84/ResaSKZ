class Product < ActiveRecord::Base
	has_many :commande
	has_many :pack

	#attr_accessible :name, :price, :stock, :echeance

	def to_s
		return self.nom
	end

	def to_str
		return self.nom
	end
end

class Pack < ActiveRecord::Base

	#################################################
	# Les packs: PG /archi /jp... regroupe des produits
	#################################################
	
	has_many :commande
	has_many :product

	#attr_accessible :nom

	def to_s
		return self.nom
	end

	def to_str
		return self.nom
	end
end

class Genre < ActiveRecord::Base
	#################################################
	# Homme / femme
	#################################################	
	has_many :personne

	#attr_accessible :sexe

	def to_s
		return self.sexe
	end

	def to_str
		return self.sexe
	end
end

class Genre < ActiveRecord::Base
	#################################################
	# Homme / femme
	#################################################	
	has_many :personnes

	#attr_accessible :sexe

	def to_s
		return self.sexe
	end

	def to_str
		return self.sexe
	end

	def long_name
		return 'Homme' if self.sexe == 'H'
		return 'Femme' if self.sexe == 'F'
	end

	#Renvoie le genre Homme si 'male'
	#Renvoie le genre Femme si 'female'
	def self.from_cas(data)
		self.find_by_nom_cas(data)
	end

	def to_cas
		return 'male' if self.sexe == 'H'
		return 'female' if self.sexe == 'F'
	end
end

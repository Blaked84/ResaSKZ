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

	#Renvoie le genre Homme si 'm'
	#Renvoie le genre Femme si 'f'
	def self.from_cas(data)
		data_traite = data == 'm' ? 'H' : data.upcase
		self.find_by_sexe(data_traite)
	end
end

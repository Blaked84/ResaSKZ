class Groupe < ActiveRecord::Base
	#################################################
	# Groupe pour des activitées
	#################################################
	
	has_many :personne, class_name: "Personne", foreign_key: "groupe_id"
	has_one :chambre

	#attr_accessible :nom

	def to_s
		return self.nom
	end

	def to_str
		return self.nom
	end
end

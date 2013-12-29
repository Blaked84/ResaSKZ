class Groupe < ActiveRecord::Base
	has_many :personne
	has_one :chambre

	#attr_accessible :nom

	def to_s
		return self.nom
	end

	def to_str
		return self.nom
	end
end

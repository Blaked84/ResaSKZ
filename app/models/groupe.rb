class Groupe < ActiveRecord::Base
	has_many :personne
	has_one :chambre

	#attr_accessible :nom
end

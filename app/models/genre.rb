class Genre < ActiveRecord::Base
	has_many :personne

	attr_accessible :sexe
end

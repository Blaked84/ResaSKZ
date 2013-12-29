class Activite < ActiveRecord::Base
	has_many :personne

	#attr_accessible :nom
end

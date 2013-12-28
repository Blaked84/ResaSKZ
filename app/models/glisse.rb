class Glisse < ActiveRecord::Base
	has_many :commande

	attr_accessible :nom
end

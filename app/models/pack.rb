class Pack < ActiveRecord::Base
	has_many :commande
	has_many :product

	#attr_accessible :nom
end

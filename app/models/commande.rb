class Commande < ActiveRecord::Base
	has_many :product

	attr_accessible :assurance, :status

end

class Product < ActiveRecord::Base
	has_many :commande
	has_many :pack

	attr_accessible :name, :price, :stock, :echeance

end

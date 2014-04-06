class Event < ActiveRecord::Base
	has_many :products
	has_many :commandes
	has_many :chambres
end

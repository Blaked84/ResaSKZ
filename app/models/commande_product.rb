class CommandeProduct < ActiveRecord::Base

	belongs_to :commande
	belongs_to :product

end

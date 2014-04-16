class ActivitePersonne < ActiveRecord::Base

	belongs_to :activite
	belongs_to :personne

end

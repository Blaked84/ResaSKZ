class ActivitesPersonne < ActiveRecord::Base

	belongs_to :activite
	belongs_to :personne

end

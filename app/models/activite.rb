class Activite < ActiveRecord::Base
	#################################################
	# Activitée auxquelles le pg/pec's peuvent 
	# s'inscrire
	#################################################

	has_many :personne

	#attr_accessible :nom

  def to_s
  	return self.nom
  end

  def to_str
    return self.nom
  end
end

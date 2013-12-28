class Personne < ActiveRecord::Base
	attr_accessible :nom, :prenom, :phone, :email, :assurance

	validates :phone, :format => { :with => /^(0[1-9][0-9]{8})?$/ }

end

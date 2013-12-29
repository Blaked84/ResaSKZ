class Personne < ActiveRecord::Base
	has_many :groupe
	has_many :commande
	has_many :activite
	has_one :genres
	has_one :usertype
	belongs_to :user, :dependent => :destroy  # à vérifier ça...

	#attr_accessible :nom, :prenom, :phone, :email, :assurance

	validates :phone, :format => { :with => /\A((0|\+[1-9]{2})[1-9][0-9]{8})?\Z/ }

end

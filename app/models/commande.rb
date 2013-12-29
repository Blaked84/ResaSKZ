class Commande < ActiveRecord::Base
	has_many :product
	has_one :pack
	belongs_to :glisse
	belongs_to :tbk
	belongs_to :personne
	belongs_to :user

	#attr_accessible :assurance, :status

end

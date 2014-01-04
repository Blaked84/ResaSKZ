class Commande < ActiveRecord::Base
	#################################################
	# Les commandes réalisées par les users.
	#################################################

	has_one :pack
	belongs_to :glisse
	belongs_to :tbk
	belongs_to :user
	has_and_belongs_to_many :products
	has_many :paiements

	#attr_accessible :assurance, :status

	def ok?
		return false
	end
end

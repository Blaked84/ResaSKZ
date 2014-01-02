class Commande < ActiveRecord::Base
	#################################################
	# Les commandes réalisées par les users.
	#################################################

	has_many :product, class_name: "Product", foreign_key: "commande_id"
	has_one :pack
	belongs_to :glisse
	belongs_to :tbk
	belongs_to :personne
	belongs_to :user

	#attr_accessible :assurance, :status

	def ok?
		return
	end
end

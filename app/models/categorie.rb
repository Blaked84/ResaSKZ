class Categorie < ActiveRecord::Base
	#################################################
	# Catégories des produit: transport, bouffe,...
	#################################################

	has_many :product
end

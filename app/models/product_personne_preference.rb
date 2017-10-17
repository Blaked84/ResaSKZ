class ProductPersonnePreference < ActiveRecord::Base
  belongs_to :personne
  belongs_to :product
  belongs_to :commande
end

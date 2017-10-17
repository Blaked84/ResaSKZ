class AddCommandeIdToProductPersonnePreferences < ActiveRecord::Migration
  def change
    add_column :product_personne_preferences, :commande_id, :integer
  end
end

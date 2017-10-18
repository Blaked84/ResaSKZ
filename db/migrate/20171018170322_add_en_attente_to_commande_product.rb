class AddEnAttenteToCommandeProduct < ActiveRecord::Migration
  def change
    add_column :commande_products, :en_attente, :boolean, default: false
  end
end

class CreateCommandesProducts < ActiveRecord::Migration
  def change
    create_table :commandes_products do |t|
    	t.belongs_to :commande
    	t.belongs_to :product
    end
  end
end

class CreateCommandesProducts < ActiveRecord::Migration
  def change
    create_table :commande_products do |t|
      t.belongs_to :commande
      t.belongs_to :product
      t.integer :nombre
      t.timestamps
    end
  end
end

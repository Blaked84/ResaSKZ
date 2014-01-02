class AddCategorieidToProduct < ActiveRecord::Migration
  def change
    add_column :products, :categorie_id, :integer
  end
end

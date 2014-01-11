class AddTbkToCommande < ActiveRecord::Migration
  def change
    add_column :commandes, :tbk_id, :integer
  end
end

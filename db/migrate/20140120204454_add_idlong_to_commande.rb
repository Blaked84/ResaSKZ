class AddIdlongToCommande < ActiveRecord::Migration
  def change
    add_column :commandes, :idlong, :string
  end
end

class AddIdlongToCommande < ActiveRecord::Migration
  def change
    add_column :commandes, :idlong, :integer
  end
end

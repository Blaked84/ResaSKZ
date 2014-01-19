class AddEventidToCommande < ActiveRecord::Migration
  def change
    add_column :commandes, :event_id, :integer
  end
end

class AddEventIdToCommandes < ActiveRecord::Migration
  def change
    add_column :commandes, :event_id, :integer
  end
end

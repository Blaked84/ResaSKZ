class AddPackIdToCommandes < ActiveRecord::Migration
  def change
    add_column :commandes, :pack_id, :integer
  end
end

class AddGlisseIdToCommandes < ActiveRecord::Migration
  def change
    add_column :commandes, :glisse_id, :integer
  end
end

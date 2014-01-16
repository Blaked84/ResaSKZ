class AddParrainIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :parrain_id, :integer
  end
end

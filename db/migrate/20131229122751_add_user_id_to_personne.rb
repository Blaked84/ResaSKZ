class AddUserIdToPersonne < ActiveRecord::Migration
  def change
    add_column :personnes, :user_id, :integer
  end
end

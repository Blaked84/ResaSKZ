class AddPersonneIdToUser < ActiveRecord::Migration
  def change
  	add_column :users, :referant_id, :integer
  end
end

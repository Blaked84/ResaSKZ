class AddModeratedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :moderated, :boolean
  end
end

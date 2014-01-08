class AddCguAcceptedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cgu_accepted, :boolean
  end
end

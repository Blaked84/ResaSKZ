class AddNameDescriptionToEvent < ActiveRecord::Migration
  def change
    add_column :events, :Name, :string
    add_column :events, :Description, :string
  end
end

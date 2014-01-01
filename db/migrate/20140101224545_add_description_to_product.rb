class AddDescriptionToProduct < ActiveRecord::Migration
  def change
    add_column :products, :description, :string
  end
end

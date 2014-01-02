class AddIdeventToProduct < ActiveRecord::Migration
  def change
    add_column :products, :id_event, :integer
  end
end

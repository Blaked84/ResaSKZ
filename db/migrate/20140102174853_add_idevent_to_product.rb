class AddIdeventToProduct < ActiveRecord::Migration
  def change
    add_column :products, :event_id, :integer
  end
end

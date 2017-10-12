class AddGammeIdToProduct < ActiveRecord::Migration
  def change
    add_column :products, :gamme_id, :integer, optional: true
  end
end

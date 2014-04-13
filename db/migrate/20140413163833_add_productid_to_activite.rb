class AddProductidToActivite < ActiveRecord::Migration
  def change
    add_column :activites, :productid, :integer
  end
end

class AddTypeProductToProducts < ActiveRecord::Migration
  def change
    add_column :products, :type_product_id, :integer, optional: true
  end
end

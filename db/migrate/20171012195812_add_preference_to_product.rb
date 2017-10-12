class AddPreferenceToProduct < ActiveRecord::Migration
  def change
    add_column :products, :preference, :integer, optional: true
  end
end

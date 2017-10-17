class RemovePreferenceFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :preference, :integer
  end
end

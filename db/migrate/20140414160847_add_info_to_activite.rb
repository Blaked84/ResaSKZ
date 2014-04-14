class AddInfoToActivite < ActiveRecord::Migration
  def change
    add_column :activites, :open, :boolean
    add_column :activites, :quick_check, :boolean
  end
end

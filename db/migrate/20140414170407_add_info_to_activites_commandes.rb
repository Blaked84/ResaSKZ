class AddInfoToActivitesCommandes < ActiveRecord::Migration
  def change
    add_column :activites_commandes, :checked, :boolean
  end
end

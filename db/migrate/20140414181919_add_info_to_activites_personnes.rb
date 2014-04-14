class AddInfoToActivitesPersonnes < ActiveRecord::Migration
  def change
    add_column :activites_personnes, :checked, :boolean
  end
end

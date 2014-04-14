class CreateActivitesPersonnes < ActiveRecord::Migration
  def change
    create_table :activites_personnes do |t|
      t.integer :activite_id
      t.integer :personne_id
      t.boolean :checked

      t.timestamps
    end
  end
end

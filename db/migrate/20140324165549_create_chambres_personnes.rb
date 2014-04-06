class CreateChambresPersonnes < ActiveRecord::Migration
  def change
    create_table :chambres_personnes do |t|
      t.integer :chambre_id
      t.integer :personne_id
    end
  end
end

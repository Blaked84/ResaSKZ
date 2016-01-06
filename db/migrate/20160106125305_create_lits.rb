class CreateLits < ActiveRecord::Migration
  def change
    create_table :lits do |t|
      t.string :name
      t.integer :chambre_id

      t.timestamps
    end
  end
end

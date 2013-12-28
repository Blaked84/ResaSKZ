class CreateGlisses < ActiveRecord::Migration
  def change
    create_table :glisses do |t|
      t.string :nom

      t.timestamps
    end
  end
end

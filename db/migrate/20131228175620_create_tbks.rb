class CreateTbks < ActiveRecord::Migration
  def change
    create_table :tbks do |t|
      t.string :nom

      t.timestamps
    end
  end
end

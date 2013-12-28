class CreatePacks < ActiveRecord::Migration
  def change
    create_table :packs do |t|
      t.string :nom

      t.timestamps
    end
  end
end

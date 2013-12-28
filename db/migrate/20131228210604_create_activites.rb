class CreateActivites < ActiveRecord::Migration
  def change
    create_table :activites do |t|
      t.string :nom

      t.timestamps
    end
  end
end

class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :nom

      t.timestamps
    end
  end
end

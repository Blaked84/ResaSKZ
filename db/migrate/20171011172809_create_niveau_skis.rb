class CreateNiveauSkis < ActiveRecord::Migration
  def change
    create_table :niveau_skis do |t|
      t.string :nom

      t.timestamps null: false
    end
  end
end

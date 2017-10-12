class CreateGammes < ActiveRecord::Migration
  def change
    create_table :gammes do |t|
      t.string :nom
      t.string :description

      t.timestamps null: false
    end
  end
end

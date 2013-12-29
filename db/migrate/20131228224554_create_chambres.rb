class CreateChambres < ActiveRecord::Migration
  def change
    create_table :chambres do |t|
      t.string :numero
      t.integer :nbrplace

      t.timestamps
    end
  end
end

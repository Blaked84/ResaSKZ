class RecreateChambres < ActiveRecord::Migration
  def change

  	drop_table :chambres

  	create_table :chambres do |t|
      t.string :numero
      t.integer :nbrplace
      t.string :zone
      t.integer :tbk_id
      t.integer :event_id

      t.timestamps
    end
  end
end

class CreateTourTetes < ActiveRecord::Migration
  def change
    create_table :tour_tetes do |t|
      t.string :mesure

      t.timestamps null: false
    end
  end
end

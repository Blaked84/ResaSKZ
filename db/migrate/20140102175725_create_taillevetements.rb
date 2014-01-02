class CreateTaillevetements < ActiveRecord::Migration
  def change
    create_table :taillevetements do |t|
      t.string :name

      t.timestamps
    end
  end
end

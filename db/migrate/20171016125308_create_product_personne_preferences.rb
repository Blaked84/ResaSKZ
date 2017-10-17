class CreateProductPersonnePreferences < ActiveRecord::Migration
  def change
    create_table :product_personne_preferences do |t|
      t.integer :preference
      t.references :personne, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

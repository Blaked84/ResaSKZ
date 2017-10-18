class CreateOptionSups < ActiveRecord::Migration
  def change
    create_table :option_sups do |t|
      t.string :nom
      t.string :couleur_cadre
      t.string :couleur_verre

      t.timestamps null: false
    end
  end
end

class CreatePaiements < ActiveRecord::Migration
  def change
    create_table :paiements do |t|
      t.string :etape

      t.timestamps
    end
  end
end

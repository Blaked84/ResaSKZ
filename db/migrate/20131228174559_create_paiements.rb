class CreatePaiements < ActiveRecord::Migration
  def change
    create_table :paiements do |t|
      t.sting :etape

      t.timestamps
    end
  end
end

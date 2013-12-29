class CreateCommandes < ActiveRecord::Migration
  def change
    create_table :commandes do |t|
      t.boolean :assurance
      t.boolean :status

      t.timestamps
    end
  end
end

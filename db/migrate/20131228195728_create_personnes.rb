class CreatePersonnes < ActiveRecord::Migration
  def change
    create_table :personnes do |t|
      t.string :nom
      t.string :prenom
      t.string :phone
      t.string :email
      t.boolean :assurance

      t.timestamps
    end
  end
end

class CreateGroupes < ActiveRecord::Migration
  def change
    create_table :groupes do |t|
      t.string :nom

      t.timestamps
    end
  end
end

class CreatePreregistrations < ActiveRecord::Migration
  def change
    create_table :preregistrations do |t|
      t.string :token
      t.string :email
      t.boolean :used

      t.timestamps
    end
  end
end

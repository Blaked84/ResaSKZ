class AddInscriptionTermineeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :inscription_terminee, :boolean
  end
end

class AddStatusToPersonne < ActiveRecord::Migration
  def change
    add_column :personnes, :status, :string
  end
end

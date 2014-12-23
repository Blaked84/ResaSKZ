class AddDisabledToPersonne < ActiveRecord::Migration
  def change
    add_column :personnes, :disabled, :boolean
  end
end

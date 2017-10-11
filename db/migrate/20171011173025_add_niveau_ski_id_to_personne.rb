class AddNiveauSkiIdToPersonne < ActiveRecord::Migration
  def change
    add_column :personnes, :niveau_ski_id, :integer
  end
end

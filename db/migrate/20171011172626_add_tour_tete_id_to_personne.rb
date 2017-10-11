class AddTourTeteIdToPersonne < ActiveRecord::Migration
  def change
    add_column :personnes, :tour_tete_id, :integer
  end
end

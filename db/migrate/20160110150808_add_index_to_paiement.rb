class AddIndexToPaiement < ActiveRecord::Migration
  def change
    add_index :paiements, :idlong
    add_index :lits_personnes, :lit_id
    add_index :lits_personnes, :personne_id
  end
end

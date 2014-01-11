class AddHashToPaiement < ActiveRecord::Migration
  def change
    add_column :paiements, :paiement_hash, :string
  end
end

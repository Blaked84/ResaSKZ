class AddCommandeidandamountToPaiement < ActiveRecord::Migration
  def change
    add_column :paiements, :commande_id, :integer
    add_column :paiements, :amount_cents, :integer
  end
end

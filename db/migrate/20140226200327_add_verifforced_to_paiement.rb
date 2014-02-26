class AddVerifforcedToPaiement < ActiveRecord::Migration
  def change
    add_column :paiements, :verified_by, :integer
    add_column :paiements, :verif_forced, :boolean
  end
end

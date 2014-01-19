class AddVerifToPaiement < ActiveRecord::Migration
  def change
    add_column :paiements, :verif, :boolean
  end
end

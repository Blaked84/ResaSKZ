class AddErreurToPaiement < ActiveRecord::Migration
  def change
    add_column :paiements, :erreur, :integer
  end
end

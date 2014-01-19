class AddVerifiedatToPaiement < ActiveRecord::Migration
  def change
    add_column :paiements, :verified_at, :datetime
  end
end

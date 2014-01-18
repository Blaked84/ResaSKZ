class AddIdlongToPaiement < ActiveRecord::Migration
  def change
    add_column :paiements, :idlong, :integer
  end
end

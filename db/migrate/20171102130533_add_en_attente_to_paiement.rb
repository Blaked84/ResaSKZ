class AddEnAttenteToPaiement < ActiveRecord::Migration
  def change
    add_column :paiements, :en_attente, :boolean, default: false
  end
end

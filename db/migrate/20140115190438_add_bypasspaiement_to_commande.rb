class AddBypasspaiementToCommande < ActiveRecord::Migration
  def change
    add_column :commandes, :bypasspaiement, :integer
  end
end

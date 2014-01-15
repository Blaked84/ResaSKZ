class AddBypassassuranceToCommande < ActiveRecord::Migration
  def change
    add_column :commandes, :bypassassurance, :integer
  end
end

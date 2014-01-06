class AddIdpersonneToCommande < ActiveRecord::Migration
  def change
    add_column :commandes, :personne_id, :integer
  end
end

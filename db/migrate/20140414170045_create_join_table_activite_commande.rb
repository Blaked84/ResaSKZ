class CreateJoinTableActiviteCommande < ActiveRecord::Migration
  def change
    create_join_table :activites, :commandes do |t|
      # t.index [:activite_id, :commande_id]
      # t.index [:commande_id, :activite_id]
    end
  end
end

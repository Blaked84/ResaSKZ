class CreateJoinTableActivitePersonne < ActiveRecord::Migration
  def change
    create_join_table :activites, :personnes do |t|
      # t.index [:activite_id, :personne_id]
      # t.index [:personne_id, :activite_id]
    end
  end
end

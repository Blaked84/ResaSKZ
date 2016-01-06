class LitsPersonnes < ActiveRecord::Migration
  def change
  	create_table :lits_personnes do |t|
      t.integer :lit_id
      t.integer :personne_id
  	end
  end
end

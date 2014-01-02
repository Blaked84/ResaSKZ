class AddTaillevetementidToPersonne < ActiveRecord::Migration
  def change
    add_column :personnes, :taillevetement_id, :integer
  end
end

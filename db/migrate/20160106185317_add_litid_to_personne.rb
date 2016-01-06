class AddLitidToPersonne < ActiveRecord::Migration
  def change
    add_column :personnes, :lit_id, :integer
  end
end

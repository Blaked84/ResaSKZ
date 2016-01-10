class AddIndexToPersonne < ActiveRecord::Migration
  def change
    add_index :personnes, :lit_id
  end
end

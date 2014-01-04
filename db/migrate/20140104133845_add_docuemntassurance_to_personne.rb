class AddDocuemntassuranceToPersonne < ActiveRecord::Migration
  def change
    add_column :personnes, :documentassurance, :boolean
  end
end

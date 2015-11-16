class AddTyperesidToPersonne < ActiveRecord::Migration
  def change
    add_column :personnes, :typeresid_id, :integer
  end
end

class AddNaissanceToPersonne < ActiveRecord::Migration
  def change
    add_column :personnes, :naissance, :datetime
  end
end

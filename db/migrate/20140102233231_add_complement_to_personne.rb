class AddComplementToPersonne < ActiveRecord::Migration
  # complement d'adresse
  def change
    add_column :personnes, :complement, :string
  end
end

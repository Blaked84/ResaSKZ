class AddPersonneaprevenirToPersonne < ActiveRecord::Migration
  def change
    add_column :personnes, :pnom, :string
    add_column :personnes, :pprenom, :string
    add_column :personnes, :plienparente, :string
    add_column :personnes, :padresse, :string
    add_column :personnes, :pcomplement, :string
    add_column :personnes, :pville, :string
    add_column :personnes, :pcodepostal, :string
    add_column :personnes, :pphone, :string
  end
end

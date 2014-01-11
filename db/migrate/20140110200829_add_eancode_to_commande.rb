class AddEancodeToCommande < ActiveRecord::Migration
  def change
    add_column :commandes, :ean, :string
  end
end

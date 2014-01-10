class AddCautionToCommande < ActiveRecord::Migration
  def change
    add_column :commandes, :caution, :boolean
  end
end

class AddCautionupdateToCommande < ActiveRecord::Migration
  def change
    add_column :commandes, :caution_updated_at, :datetime
  end
end

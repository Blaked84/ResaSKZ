class AddNomPecsToTbks < ActiveRecord::Migration
  def change
    add_column :tbks, :nom_pecs, :string
  end
end

class AddDiminutifToTbks < ActiveRecord::Migration
  def change
    add_column :tbks, :diminutif, :string
  end
end

class AddDiminutifToTbks < ActiveRecord::Migration
  def change
    add_column :tbks, :diminutif, :string

    Tbk.all.each do |t|
    	t.update_attribute(:diminutif,tbk.nom_pecs[0..1].downcase)
    end

  end
end

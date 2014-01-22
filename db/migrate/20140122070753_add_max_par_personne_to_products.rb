class AddMaxParPersonneToProducts < ActiveRecord::Migration
  def change
    add_column :products, :max_par_personne, :integer
  end
end

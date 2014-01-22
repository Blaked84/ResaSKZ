class AddMaxParPersonneToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :max_par_personne, :integer
  end
end

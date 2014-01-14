class AddNomCompletToGenres < ActiveRecord::Migration
  def change
    add_column :genres, :nom_complet, :string
  end
end

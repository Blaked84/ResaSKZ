class AddNomCasToGenres < ActiveRecord::Migration
  def change
    add_column :genres, :nom_cas, :string
  end
end

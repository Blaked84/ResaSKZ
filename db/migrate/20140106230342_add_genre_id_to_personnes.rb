class AddGenreIdToPersonnes < ActiveRecord::Migration
  def change
    add_column :personnes, :genre_id, :integer
  end
end

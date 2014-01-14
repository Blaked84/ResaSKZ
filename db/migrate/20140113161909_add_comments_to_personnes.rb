class AddCommentsToPersonnes < ActiveRecord::Migration
  def change
    add_column :personnes, :commentaires, :string
    add_column :personnes, :commentaires_admin, :string
  end
end

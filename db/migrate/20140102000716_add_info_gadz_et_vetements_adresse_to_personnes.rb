class AddInfoGadzEtVetementsAdresseToPersonnes < ActiveRecord::Migration
  def change
    add_column :personnes, :adresse, :string
    add_column :personnes, :ville, :string
    add_column :personnes, :codepostal, :integer
    add_column :personnes, :bucque, :string
    add_column :personnes, :fams, :string
    add_column :personnes, :promo, :string
    add_column :personnes, :idGadzOrg, :string
    add_column :personnes, :taille, :integer
    add_column :personnes, :pointure, :integer
  end
end

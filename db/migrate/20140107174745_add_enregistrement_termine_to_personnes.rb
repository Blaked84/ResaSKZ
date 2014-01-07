class AddEnregistrementTermineToPersonnes < ActiveRecord::Migration
  def change
    add_column :personnes, :enregistrement_termine, :boolean
  end
end

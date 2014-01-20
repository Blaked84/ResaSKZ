class AddTypePersToPersonnes < ActiveRecord::Migration
  def change
    add_column :personnes, :type_pers, :string
  end
end

class AddAttenteOptionSupIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :en_attente, :boolean, optional: true, default: false
    add_column :products, :option_sup_id, :integer, optional: true
  end
end

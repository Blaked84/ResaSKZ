class AddIsVotableToProducts < ActiveRecord::Migration
  def change
    add_column :products, :votable, :boolean, optional: true
  end
end

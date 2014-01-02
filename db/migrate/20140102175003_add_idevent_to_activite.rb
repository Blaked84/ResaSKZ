class AddIdeventToActivite < ActiveRecord::Migration
  def change
    add_column :activites, :id_event, :integer
  end
end

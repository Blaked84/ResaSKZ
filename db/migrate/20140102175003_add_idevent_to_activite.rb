class AddIdeventToActivite < ActiveRecord::Migration
  def change
    add_column :activites, :event_id, :integer
  end
end

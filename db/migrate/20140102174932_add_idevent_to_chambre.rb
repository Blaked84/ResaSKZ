class AddIdeventToChambre < ActiveRecord::Migration
  def change
    add_column :chambres, :event_id, :integer
  end
end

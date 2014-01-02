class AddIdeventToChambre < ActiveRecord::Migration
  def change
    add_column :chambres, :id_event, :integer
  end
end

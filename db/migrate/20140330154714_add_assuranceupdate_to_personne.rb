class AddAssuranceupdateToPersonne < ActiveRecord::Migration
  def change
    add_column :personnes, :assurance_uptated_at, :datetime
  end
end

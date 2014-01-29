class AddModeratedToPersonnes < ActiveRecord::Migration
  def change
    add_column :personnes, :moderated, :boolean

    Personne.all.each do |p|
    	p.update_attribute(:moderated, true)
    end

  end
end

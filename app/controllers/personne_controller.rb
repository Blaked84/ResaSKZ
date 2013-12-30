class PersonneController < ApplicationController
  def index
  	@personne = Personne.all.sort_by{|a| a.nom}
    # authorize! :show, @admin
    @titre = "Personne"
  end

  def show
  end

  def edit
  end
end

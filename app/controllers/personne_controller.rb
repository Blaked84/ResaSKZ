class PersonneController < ApplicationController
  def index
  	@personne = Personne.all.sort_by{|a| a.nom}
    # authorize! :show, @admin
    @titre = "Personne"
  end

  def show
  	@personne = Personne.find(params[:id])
    @taillevetement = @personne.taillevetement.name
    @commande = @personne.commande

  end

  def edit
  end
end

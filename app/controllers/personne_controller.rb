class PersonneController < ApplicationController
  def index
  	@personne = Personne.all.sort_by{|a| a.nom}
    # authorize! :show, @admin
    @titre = "Personne"
  end

  def show
  	@personne = Personne.find(params[:id])
    @taillevetement = Taillevetement.find(@personne.taillevetement_id).name
    @commande = Commande.all.where(personne_id: @personne.id)

  end

  def edit
  end
end

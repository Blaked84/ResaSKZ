class PersonnesController < ApplicationController
  

  def index
  	@personnes = Personne.all.sort_by{|a| a.nom}
    authorize! :show, @personnes
    @titre = "Personne"
  end

  def show
    @personne = Personne.find(params[:id])
    authorize! :show, @personne
    @personne.taillevetement ? @taillevetement = @personne.taillevetement.name : nil
    @commandes = @personne.commandes

  end

  def edit
  end
end

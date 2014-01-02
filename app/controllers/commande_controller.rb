class CommandeController < ApplicationController
  def index
  	@commande = Commande.all.sort_by{|a| a.updated_at}
  end

  def show
 	@commande = Commande.find(params[:id])
 	@personne = Personne.find(@commande.personne_id).nom_complet

  end
end

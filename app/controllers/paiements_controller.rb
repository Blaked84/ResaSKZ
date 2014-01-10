class PaiementsController < ApplicationController
  
  load_and_authorize_resource

  def create
  # utiliser SecureRandom.hex(10) pour le hash du paiement (paiement_hash)
  end

  def index
    authorize! :read_admin, User
  	@paiements=Paiement.all
  end

  def show
  	authorize! :show, @commandes
  	@paiement=Paiement.find(params[:id])
  	@commande=@paiement.commande
  	@personne=@commande.personne
  	@referant=@personne.referant
  end

  def update
  end
end

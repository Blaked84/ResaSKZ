class CommandeController < ApplicationController
  def index
  	@commande = Commande.all.sort_by{|a| a.updated_at}
  end

  def show
 	@commande = Commande.find(params[:id])

  end
end

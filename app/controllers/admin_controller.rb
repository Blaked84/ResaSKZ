class AdminController < ApplicationController
  def index
  	@nbrPersonnes = Personne.all.count.to_s
  	@nbrPersonnesNonAssuree = Personne.where( assurance: false).count

  	@nbrCommande = Commande.all.count.to_s
  	@nbrCommandeValidee = Commande.where( status: true).count.to_s
  	
  end
end

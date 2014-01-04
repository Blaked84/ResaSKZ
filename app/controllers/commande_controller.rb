class CommandeController < ApplicationController
  def index
  	@commande = Commande.all.sort_by{|a| a.updated_at}
  end

  def show
 	@commande = Commande.find(params[:id])
 	@personne = Personne.find(@commande.personne_id).nom_complet

 	#à definir quand les associations commande <-> produits seront faites
	# liste des produit d'une commande
 	@produit

 	# total du prix d'une commande
 	@total

 	# liste des paiements associés à une commande
 	@paiements = Paiement.where(commande_id: params[:id])
 	# total des paiements d'une commande pour préparer à la vérification
 	@totalpaiement=0
 	@paiements.each do |p|
 		@totalpaiement+=p.amount_euro
 	end
 	
  end
end

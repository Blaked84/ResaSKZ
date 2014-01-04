class CommandeController < ApplicationController
  def index
  	@commande = Commande.all.sort_by{|a| a.updated_at}
  end

  def show
 	@commande = Commande.find(params[:id])
 	@personne = Personne.find(@commande.personne_id)

 	##### à definir quand les associations commande <-> produits seront faites
	# liste des produit d'une commande
 	@produit

 	# total du prix d'une commande
 	total_cents =10000 #encentimesvlaur arbitraire pour test. à coder


 	# liste des paiements associés à une commande
 	@paiements = Paiement.where(commande_id: params[:id])
 	# total des paiements d'une commande pour préparer à la vérification
 	totalpaiement_cents=0
 	@paiements.each do |p|
 		totalpaiement_cents+=p.amount_cents
 	end
 	@totalpaiement_euro = totalpaiement_cents /100.0

 	@paiement_du_euro = (total_cents - totalpaiement_cents) / 100.0
 	##### Vérification du statut d'une commande
 	# status = true si:
 	# @total = @totalpaiement ET
 	# (la personne à une assurance ET a donné un justificatif) OU a dans sa commande un produit assurance 
 	
 	if total_cents == totalpaiement_cents
 		@paiementok = true 
 	else
 		@paiementok = false
 	end

 	assurance_personne = @personne.assurance
 	assurance_document_personne = @personne.documentassurance
 	assurance_dans_produit = false #vlaur arbitraire pour test. à coder

 	if ((@personne.assurance and @personne.documentassurance) or assurance_dans_produit)
 		@assuranceok = true
 	else
 		@assuranceok = false
 	end

 	if @assuranceok && @paiementok
 		@status=true
 	else
 		@status=false
 	end
  end
end

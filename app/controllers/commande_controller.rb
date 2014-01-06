class CommandeController < ApplicationController
  def index
  	@commande = Commande.all.sort_by{|a| a.updated_at}
  end

  def show
 	@commande = Commande.find(params[:id])
 	@personne = @commande.personne

 	##### à definir quand les associations commande <-> produits seront faites
	# liste des produit d'une commande
 	@produits = @commande.products

 	# total du prix d'une commande
 	total = @produits.map{|p| p.price}.sum
 	@total_euro = total /100.0

 	# liste des paiements associés à une commande
 	@paiements = @commande.paiements
 	# total des paiements d'une commande pour préparer à la vérification
 	@totalpaiement_euro = @paiements.map{|p| p.amount_euro}.sum

 	@paiement_du_euro = @total_euro - @totalpaiement_euro
 	##### Vérification du statut d'une commande
 	# status = true si:
 	# @total = @totalpaiement ET
 	# (la personne à une assurance ET a donné un justificatif) OU a dans sa commande un produit assurance 
 	
 	# if total_cents == totalpaiement_cents
 	# 	@paiementok = true 
 	# else
 	# 	@paiementok = false
 	# end

 	# assurance_personne = @personne.assurance
 	# assurance_document_personne = @personne.documentassurance
 	# assurance_dans_produit = false #vlaur arbitraire pour test. à coder

 	# if ((@personne.assurance and @personne.documentassurance) or assurance_dans_produit)
 	# 	@assuranceok = true
 	# else
 	# 	@assuranceok = false
 	# end

 	# if @assuranceok && @paiementok
 	# 	@status=true
 	# else
 	# 	@status=false
 	# end

 	@status = false
  end
end

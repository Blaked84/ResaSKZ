class CommandesController < ApplicationController
  
  load_and_authorize_resource
  
  def create
    # pour la generation du code ean13 qui sert aussi d'id publique:
    # (SecureRandom.random_number *10**14).to_s[0,13]
  end

  def index
  	@commandes = Commande.all.sort_by{|a| a.updated_at}
  	authorize! :show, @commandes
  end

  def show
  	@commandes = Commande.find(params[:id])
  	authorize! :show, @commande

 	@personne = @commande.personne

 	##### à definir quand les associations commande <-> produits seront faites
	# liste des produit d'une commande
 	@produits = @commande.products

 	# total du prix d'une commande
 	# total = @produits.map{|p| p.price}.sum
 	@total_euro = @commande.montant_total.to_i / 100.0

 	# liste des paiements associés à une commande
 	@paiements = @commande.paiements
 	# total des paiements d'une commande pour préparer à la vérification
 	@totalpaiement_euro = @commande.montant_paye / 100.0

 	@paiement_du_euro = @commande.montant_du.to_i / 100.0
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

 	@status = @commande.complete?
  end
end

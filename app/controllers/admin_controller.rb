class AdminController < ApplicationController
  before_action :admin_only
  before_action :check_register_workflow


  def index

  	

  	@commandes=Commande.all
  	
  	@nbrPersonnes = Personne.all.count
  	@nbrPersonnesNonAssuree = Personne.where( assurance: false).count

  	@nbrCommande = @commandes.count
  	@nbrCommandeValidee = Commande.where( status: true).count
  	
    @nbrCommandesNonValidee = @nbrCommande-@nbrCommandeValidee

  	@tbk= Tbk.all
    @event=Event.all

    @nombre_commande_avec_paiement = Paiement.where(verif: true).map{|p| p.commande}.uniq.count


  	# @tbkcom=Array.new
  	# @tbk.each_with_index do |t,i| 
  	# 	@tbkcom<<[t.nom,t.commandes.count] 
  	# end

  	# @etatcomtbk=@tbk.all.map{|t| [t.nom,  t.commandes.all.map{|c| c.complete?}.count(false)]}


  end

  def graph
    authorize! :read_admin, User
    @event=Event.all
  end

  def check_in

  end
  
end

class AdminController < ApplicationController
  def index

  	authorize! :read_admin, User

  	@commandes=Commande.all
  	
  	@nbrPersonnes = Personne.all.count
  	@nbrPersonnesNonAssuree = Personne.where( assurance: false).count

  	@nbrCommande = @commandes.count
  	@nbrCommandeValidee = Commande.where( status: true).count
  	
    @nbrCommandesNonValidee = @nbrCommande-@nbrCommandeValidee

  	@tbk= Tbk.all
    @event=Event.all

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
  
end

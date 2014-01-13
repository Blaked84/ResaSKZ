class AdminController < ApplicationController
  def index

  	authorize! :read_admin, User

  	@commandes=Commande.all
  	
  	@nbrPersonnes = Personne.all.count.to_s
  	@nbrPersonnesNonAssuree = Personne.where( assurance: false).count

  	@nbrCommande = @commandes.count.to_s
  	@nbrCommandeValidee = Commande.where( status: true).count.to_s
  	
  	@tbk= Tbk.all

  	# @tbkcom=Array.new
  	# @tbk.each_with_index do |t,i| 
  	# 	@tbkcom<<[t.nom,t.commandes.count] 
  	# end

  	# @etatcomtbk=@tbk.all.map{|t| [t.nom,  t.commandes.all.map{|c| c.complete?}.count(false)]}


  end

  
end

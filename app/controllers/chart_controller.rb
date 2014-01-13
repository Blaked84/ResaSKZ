class ChartController < ApplicationController
	# json pour le gros graph
  def etatcommande
  	render :json => Tbk.all.map{|t| [t.nom,  t.commandes.all.map{|c| c.complete?}.count(false)]}
  end

  def paiement
  	@paiement=Paiement.all
  	@commandes=Commande.all
  	@paiement_tot_euro=@paiement.all.map{ |p| p.amount_cents  }.sum / 100.0
  	@total_du_euro=@commandes.all.map { |c| c.montant_total }.sum / 100.0
  	a=[
  		["Total payé", @paiement_tot_euro],
  		["Total dû", @total_du_euro]]
  	render :json => a
  end

  def tbkcommandes
  	@tbkcom=Array.new
  	Tbk.all.each_with_index do |t,i| 
  		@tbkcom<<[t.nom,t.commandes.count] 
  	end
  	render :json => @tbkcom
  end
end

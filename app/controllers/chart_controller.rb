class ChartController < ApplicationController
	# json pour le gros graph
  def etatcommande
  	render :json => Tbk.all.map{|t| [t.nom,  t.commandes.all.map{|c| c.complete?}.count(false)]}
  end
end

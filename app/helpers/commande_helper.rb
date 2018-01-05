module CommandeHelper

	def excel_block

		pool_size=Configurable[:export__commande_pool_size]

		nbr_pages=(Commande.count/pool_size.to_f).ceil
		nbr_pages_trd=(Commande.count/pool_size.to_f).ceil

		render :partial => "commandes/excel_block", :locals => {:nbr_pages => nbr_pages}

	end
	
	


end

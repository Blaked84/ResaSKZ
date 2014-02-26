module CommandeHelper

	def excel_block

		pool_size=300

		nbr_pages=(Commande.count/pool_size.to_f).ceil

		render :partial => "commandes/excel_block", :locals => {:nbr_pages => nbr_pages}

	end


end

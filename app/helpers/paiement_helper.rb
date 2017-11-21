module PaiementHelper
  def paiements_excel_block

		pool_size=Configurable[:export__commande_pool_size]

		nbr_pages=(Paiement.where(en_attente: true).count/pool_size.to_f).ceil

		render :partial => "paiements/excel_block", :locals => {:nbr_pages => nbr_pages}

	end
end

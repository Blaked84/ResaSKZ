class CommandeProductsController < ApplicationController
  def check_nombre

  	cp=CommandeProduct.find_by_id params[:id]
  	commande=Commande.find_by_id(params[:commande_id])
  	product_id=Product.find_by_id(params[:product_id])

  	cp ||= commande.commande_products.find_by_product_id product_id if commande

  	render :json => cp ? cp.nombre : 0
  end
end

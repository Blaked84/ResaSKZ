class CommandeProductsController < ApplicationController
    before_action :check_register_workflow


  def check_nombre

  	cp=CommandeProduct.find_by_id params[:id]
  	commande=Commande.find_by_id(params[:commande_id])
  	product_id=Product.find_by_id(params[:product_id])

  	cp ||= commande.commande_products.find_by_product_id product_id if commande

  	render :json => cp ? cp.nombre : 0
  end

  def validate
    if @current_user.admin?
      set_commande_products
      @commande_products.en_attente=false
      if @commande_products.save
        redirect_to commande_path(@commande_products.commande_id), notice: 'Le produit a bien été validé'
      else
        redirect_to commande_path(@commande_products.commande_id), alert: 'Erreur : Produit pas validé'
      end
    end

  end


  private

    def set_commande_products
      @commande_products = CommandeProduct.find(params[:id])
    end
end

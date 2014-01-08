class ProductsController < ApplicationController

  load_and_authorize_resource :except => [:index]

  def index
    if params[:event_id]
    	@products =	Product.all.where(event_id: params[:event_id]).sort_by{|a| a.name}
    	@evenement = Event.find(params[:event_id]).Name
    else
    	@products = Product.all.sort_by{|a| a.name}
    end
    authorize! :read, @products
    @categories = Categorie.all
    @titre = "Produit"
  end

  def show
  	@products = Product.find(params[:id])
  	@evenement = Event.find(@product.event_id).Name

  end

  # def product_add_to_commande
    
  #   commande=Personne
    
  #   Product.each do |prd|
  #     if params["prd_" + pdr.id.to_s]

  # end
end

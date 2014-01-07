class ProductsController < ApplicationController

  load_and_authorize_resource :except => [:index]

  def index
    if params[:event]
    	@products =	Product.all.where(event_id: params[:event]).sort_by{|a| a.name}
    	@evenement = Event.find(params[:event]).Name
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
end

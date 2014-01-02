class ProductController < ApplicationController
  def index
    if params[:event]
    	@product =	Product.all.where(event_id: params[:event]).sort_by{|a| a.name}
    	@evenement = Event.find(params[:event]).Name
    else
    	@product = Product.all.sort_by{|a| a.name}
    end
    # authorize! :show, @product
    @titre = "Produit"
  end

  def show
  	@product = Product.find(params[:id])
  	@evenement = Event.find(@product.event_id).Name

  end
end

class ProductController < ApplicationController
  def index
    @product = Product.all.sort_by{|a| a.name}
    # authorize! :show, @product
    @titre = "Produit"
  end
end

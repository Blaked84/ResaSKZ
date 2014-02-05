# -*- encoding : utf-8 -*-
class ProductsController < ApplicationController

  before_action :check_register_workflow

  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    if params[:event_id]
      @products = Product.all.where(event_id: params[:event_id]).sort_by{|a| a.name}
      @evenement = Event.find(params[:event_id]).name
    else
      @products = Product.all.sort_by{|a| a.name}
    end
    authorize! :read, @products
    @categories = Categorie.all
    @titre = "Produit"

  end

  # GET /products/1
  # GET /products/1.json
  def show
    authorize! :read_admin, User
    @product = Product.find(params[:id])
    @evenement = @product.event.name
  end

  # GET /products/new
  def new
    authorize! :read_admin, User
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    authorize! :read_admin, User
  end

  # POST /products
  # POST /products.json
  def create
    authorize! :read_admin, User
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render action: 'show', status: :created, location: @product }
      else
        format.html { render action: 'new' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    authorize! :read_admin, User
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    authorize! :read_admin, User
    # @product.destroy
    # respond_to do |format|
    #   format.html { redirect_to products_url }
    #   format.json { head :no_content }
    # end
  end

  # def product_add_to_commande
  #   commande=Personne
  #   Product.each do |prd|
  #     if params["prd_" + pdr.id.to_s]
  # end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name,:stock,:max_par_personne,:event_id,:categorie_id,:price)
    end
end

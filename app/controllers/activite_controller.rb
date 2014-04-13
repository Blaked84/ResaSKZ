class ActiviteController < ApplicationController
  
  #
  #
  #
  #
  #
  #
  ## attention il faut faire les autorisations
  #
  #
  #
  #
  #
  #
  #
  #
  def index
  	@activite=Activite.all
  end

  def create
  end

  def show
  	@activite=Activite.find(params[:id])
  end

  def import
  	@products=Product.all
  	@categories = Categorie.all
  end

  def import_product_as_activite
  	activite= Activite.new
  	activite.import_from_product(params[:productid])
  	activite.save
  	redirect_to :back, notice: "Activitée ajoutée"
  end

  def validate_personne_by_ean
  	ean=params[:ean]
  	activityid=params[:id]
  	redirect_to :back, notice: "Activitée ajoutée" +" "+ ean + " " + activityid.to_s
  end
end

class ActiviteController < ApplicationController

  before_action :admin_only

  def index
  	@activite=Activite.all
  end

  def create
  end

  def show
  	@activite=Activite.find(params[:id])
  	@personnes=@activite.personnes
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
  	commandes=Commande.where(ean: ean )

  	if !commandes.any?
  		# si on ne trouve pas de commande avec cet EAN
  		redirect_to :back, alert: "Cette commande n'existe pas"
  	else
  		personne=commandes.take!.personne

  		personneid=personne.id
  		activite=Activite.find(activityid)
  		# si l'activité est open, on ajoute la personne à la liste. Sinon on la refuse.
  		if activite.open
  			#ah bah oui il faut le coder ça
  		else
  			if activite.personnes.find_by(id: personneid).present?
  				#si la personne existe bien dans la liste on vérifie que si elle est déjà passée
  				if activite.is_checked?(personneid)
  					redirect_to :back, alert:  personne.nom_complet + " est déjà passé!"

  				else
  					activite.check_personne(personneid)
  					redirect_to :back, notice: "Passage de "+ personne.nom_complet + " Validé!"
  				end
  			else
  				redirect_to :back, alert:  personne.nom_complet + " N'est pas inscrit(e)!"
  			end
  		end
  	end
  end
end
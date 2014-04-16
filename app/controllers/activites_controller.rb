# -*- encoding : utf-8 -*-
class ActivitesController < ApplicationController

  before_action :admin_only

  def index
  	@activite=Activite.all
    @events=Event.all
  end

  def new
    @activite = Activite.new
    @events=Event.all
  end

  def create
    @activite = Activite.new(activite_params)
    authorize! :create, @activite

    respond_to do |format|
      if @activite.save
        format.html { redirect_to activites_path, notice: 'Votre activite a bien été créée' }
        format.json { head :no_content }
      else
        format.html { render 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    set_activite
    authorize! :update, @activite
    @events=Event.all.to_a
    @packs=Pack.all
  end

  def update
    set_activite
    authorize! :create, @activite

    respond_to do |format|
      if @activite.update(activite_params)
        format.html { redirect_to activites_path, notice: 'Votre activite a bien été éditée' }
        format.json { head :no_content }
      else
        format.html { render 'edit' }
        format.json { render json: @activite.errors, status: :unprocessable_entity }
      end
    end
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
    activite.open=false
  	activite.save!
  	redirect_to :back, notice: "Activitée ajoutée"
  end

  def validate_personne_by_name
     activityid=params[:id]
     activite=Activite.find(activityid)
     eventid=activite.event_id
     personneid=params[:id_pers]
     commande=Personne.find(personneid).commandes.find_by event_id: eventid
     ean=commande.ean
     redirect_to validate_personne_by_ean_activites_path({:id => activityid, :ean => ean}) 

  end

  def validate_personne_by_ean
    ean=params[:ean]
    activityid=params[:id]
    commandes=Commande.where(ean: ean )

    if !commandes.any?
      # si on ne trouve pas de commande avec cet EAN
      redirect_to activite_path(activityid), alert: "Cette commande / personne n'existe pas"
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
            redirect_to activite_path(activityid), alert:  personne.nom_complet + " est déjà passé!"

          else
            activite.check_personne(personneid)
            redirect_to activite_path(activityid), notice: "Passage de "+ personne.nom_complet + " Validé!"
          end
        else
          redirect_to activite_path(activityid), alert:  personne.nom_complet + " N'est pas inscrit(e)!"
        end
      end
    end
  end

  def export
    set_activite

    @activite = @activite.serialize

    respond_to do |format|
      format.xls do
        response.headers['Content-Disposition'] = 'attachment; filename="' +"export_activite_"+Date.today.to_s+ '.xls"'
      end
    end

  end

  private

  def activite_params
    params.require(:activite).permit(:nom,:event_id,:open)
  end

  def set_activite
    @activite = Activite.find(params[:id])
  end

end
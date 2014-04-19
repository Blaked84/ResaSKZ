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
    @nbtotal=@personnes.count
    @nbcheck=ActivitesPersonne.where(activite_id: params[:id], checked: true).count
    @parchambre=true if @activite.productid.to_i >= 1000
  end

  def recap
    @chambre=Chambre.find(params[:chambreid])
    @activite=Activite.find(params[:activityid])
    @categorie_id=params[:categorieid].to_i

  end

  def import
  	@products=Product.all
  	@categories = Categorie.all
    @events=Event.all
  end

  def import_product_as_activite
  	activite= Activite.new
  	activite.import_from_product(params[:productid])
    activite.open=false
    activite.save!
    redirect_to :back, notice: "Activitée ajoutée"
  end

  def import_cat_product_as_activite
    activite= Activite.new
    activite.import_from_cat_product(params[:categorieid],params[:eventid])
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
   redirect_to validate_personne_by_ean_activites_path(:id => activityid, :ean => ean), method: :post 

 end

 def validate_personne_by_ean
    # 2 comportement différents en fonction de si c'est une catégorie importée où non.
    # on verifie ça sur l'id produit. Si plus grand que 1000 c'est une categorie. c'est sale. je sais.
    ean=params[:ean]
    activityid=params[:id].to_i
    commandes=Commande.where(ean: ean )

    if !commandes.any?
      # si on ne trouve pas de commande avec cet EAN
      redirect_to activite_path(activityid), alert: "Cette commande / personne n'existe pas"
    else

      personne=commandes.take!.personne

      personneid=personne.id
      activite=Activite.find(activityid)
      
      # on verifie que c'est une activite qui vient d'un produit ou categorie de produits
      if activite.productid.to_i >= 1000
        chambre=personne.chambres.take!
        personnes=chambre.personnes
        #l'activité est forcement not open
        # on verifie si qq'un de la chanbre est déj) passé

        if personnes.map{|p| ActivitesPersonne.where(activite_id:activityid, personne_id:p.id).take!.checked unless ActivitesPersonne.where(activite_id:activityid, personne_id:p.id).empty?}.include? true
          redirect_to activite_path(activityid), alert: personnes.map { |p| p.nom_complet + " " }.to_s + " sont déjà passés"

       else

        personnes.each{|p| activite.check_personne(p.id) unless (activite.personnes.find_by id: p.id).nil?}
        # on recalcule l'id de la categorie
        categorieid=activite.productid.to_i - 1000
        redirect_to recap_activites_path(:activityid => activityid, :chambreid => chambre.id, :categorieid => categorieid), notice: "Passage de "+ personnes.map { |p| p.nom_complet + " " }.to_s + " Validé!"
      end
      else


      # si l'activité est open, on ajoute la personne à la liste. Sinon on la refuse.
      if activite.open
        #ah bah oui il faut le coder ça
        if activite.personnes.find_by(id: personneid).present?
          redirect_to activite_path(activityid), alert:  personne.nom_complet + " est déjà passé!"
        else
          activite.add_personne(personneid)
          activite.check_personne(personneid)
          redirect_to activite_path(activityid), notice: "Passage de "+ personne.nom_complet + " Validé!"

        end
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
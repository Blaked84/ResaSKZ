# -*- encoding : utf-8 -*-
class PersonnesController < ApplicationController
  
  before_action :check_register_workflow, except: [:personne_infos, :update_personne_infos]
  before_action :set_personne, only: [:show, :edit, :update, :destroy]
  # Necessaire pour les permissions de l'autocomplete
  before_action :admin_only, only: [:autocomplete_personne_nom]
  helper_method :sort_column, :sort_direction
  autocomplete :personne, :nom, :full => true, :display_value => :nom_complet, extra_data: [:id, :prenom, :disabled ] 


  require 'will_paginate/array'

  def index
    # si appellé en post on recupere les param et on resteind la recherche
    search = params[:nom]
    id = params[:id]
    if id != "" and !id.nil?
      redirect_to personne_path(id)
    elsif search.nil?
      @personnes = Personne.all.order(sort_column + " " + sort_direction).paginate(:page => params[:page],:per_page => 50)
    else
      @personnes = Personne.all.where('nom LIkE ?','%' +search+'%').order(sort_column + " " + sort_direction).paginate(:page => params[:page],:per_page => 50)
    end
    authorize! :show, @personnes
    @nb_by_type = Personne.all.map { |p| p.type_pers  }.each_with_object(Hash.new(0)) { |type,counts| counts[type] += 1 }
    @to_moderate_nbr=Personne.where(moderated: [false, nil]).count
    @titre = "Personnes"
  end

  def to_moderate
    @personnes = Personne.where(moderated: [false, nil]).sort_by{|a| a.nom}.paginate(:page => params[:page],:per_page => 50)
    authorize! :show, @personne
    @titre = "Personnes à moderer"
  end

  def show
    authorize! :show, @personne
    @personne.taillevetement ? @taillevetement = @personne.taillevetement.name : nil
    @commandes = @personne.commandes

  end

  def edit
  end

  def update
  end

  def create
    @personne = Personne.new(personne_params(registration: true))
    authorize! :create, @personne

    @personne.type_pers="Pec's"

    @commandes = @personne.commandes.build(event_id: personne_params["commandes_attributes"]["0"]["event_id"],
                                          tbk_id: personne_params["commandes_attributes"]["0"]["tbk_id"],
                                          glisse_id: personne_params["commandes_attributes"]["0"]["glisse_id"])
    @commandes.idlong = @commandes.gen_idlong

    # Packs
    @packs = @commandes.commande_products.build(product_id: personne_params["commandes_attributes"]["0"]["products_attributes"]["0"]["id"],
                                                     nombre: 1)
    # Transports
    @transportsar = @commandes.commande_products.build(product_id: personne_params["commandes_attributes"]["0"]["products_attributes"]["1"]["id"],
                                                     nombre: 1)
    @transportsa = @commandes.commande_products.build(product_id: personne_params["commandes_attributes"]["0"]["products_attributes"]["2"]["id"],
                                                     nombre: 1)
    @transportsr = @commandes.commande_products.build(product_id: personne_params["commandes_attributes"]["0"]["products_attributes"]["3"]["id"],
                                                     nombre: 1)
    if @transportsar.present? && @transportsar.nombre > 0
      if @transportsa.present? && @transportsa.nombre > 0
        @transportsa.destroy
      end
      if @transportsr.present? && @transportsr.nombre > 0
        @transportsr.destroy
      end
    elsif (@transportsa.present? && @transportsa.nombre > 0) or (@transportsr.present? && @transportsr.present?)
      @transportsar.destroy
    end

    # Options Pack food
    if personne_params["commandes_attributes"]["0"]["products_attributes"]["4"].present?
      @options = @commandes.commande_products.build(product_id: personne_params["commandes_attributes"]["0"]["products_attributes"]["4"]["id"],
                                                    nombre: 1)
    end

    respond_to do |format|
      if @personne.save && @personne.update(enregistrement_termine: true, moderated: true)
        format.html { redirect_to dashboard_user_url @personne.user, :notice => 'User was successfully updated.' }
        format.json { head :no_content }
      else
        @user=User.find(@personne.user_id)
        format.html { redirect_to new_personne_user_path(@user), alert: "Un problème empêche la création du compte" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end

  def personne_infos 
    set_personne
    authorize! :update, @personne
    @events = Event.all
    @type_products = TypeProduct.all
    @commandes = @personne.commandes.first
  end

  def update_personne_infos 
    set_personne
    # authorize! :update, @personne
    respond_to do |format|
      if (@personne.update_attributes(personne_params) && @personne.update_attribute(:enregistrement_termine, true))
        if @current_user.admin?
          format.html { redirect_to personnes_path , notice: 'User was successfully updated.' }
        else
          format.html { redirect_to dashboard_user_url @personne.user, notice: 'Compte mis à jour!' }
        end
        format.json { head :no_content }
      else
        format.html { render action: 'personne_infos' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def typeresids
        set_personne
        authorize! :update, @personne
        @typeresids = Typeresid.all
  end

  #affiche les liste des lits par chambre pour le choix effectué par les utilisateurs
  def choix_chambre
    set_personne
    authorize! :update, @personne
    @lits = @personne.lits
    gon.personne_id = @personne.id
  end

  #appellé en POST uniquement pour attribuer le lit
  def choix_lit
    set_personne
    authorize! :update, @personne
    lit = Lit.find(params[:lit_id])
    choix = params[:choix].to_i # 1 quand on prend un lit, 0 quand on le rend
    #si le lit est bien accéssible on l'attibue
    if @personne.lits.include? lit
      if choix == 1
        if lit.personne.blank?
          @personne.lit = lit
        end
      else
        @personne.lit = nil
      end
      if @personne.save
        respond_to do |format|
          format.html { redirect_to :back}
        end
      end
    else
      respond_to do |format|
          format.html { redirect_to :back, :notice => "tu n'as pas accès à cette chambre" }
        end
      #sinon on renvoie à la page avec un message d'erreur 


    end
  end

  def refresh_list_lits
    set_personne
    authorize! :update, @personne
    #@lits = @personne.lits.includes(:chambre).includes(:lits).all
    #@chambres = @lits.map{|l| l.chambre}.flatten.compact.uniq
    @chambres = @personne.chambres.includes(:lits,:personnes)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    set_personne
    authorize! :destroy, @personne
    user = @personne.user
    @personne.disabled = true
    @personne.save
    respond_to do |format|
      format.html { redirect_to dashboard_user_url(user) }
      format.json { head :no_content }
    end
  end

  def add_commande
    set_personne
    redirect_to  :controller => 'commandes', :action => 'new', :pers_id => @personne.id
  end

  def add_assurance
    @personnes = Personne.where("assurance_uptated_at <> ''").where(documentassurance: true).order(assurance_uptated_at: :desc).limit(5)
    @personne = Personne.new
    authorize! :show, @personnes
    @to_moderate_nbr=Personne.where(moderated: [false, nil]).count
    @titre = "Personnes"
  end

  def validate_assurance
    authorize! :read_admin, User
    personne=Personne.find(params[:id])
    personne.a_donne_justificatif_assurance
    redirect_to :back
  end

  def validate_assurance_batch
    authorize! :read_admin, User
    file=params[:file]
    nbre_assurance_validee = 0
    if File.extname(file.original_filename) == '.csv'
      CSV.foreach(file.path,headers: true) do |row|
        Commande.find(row['commande_id'].to_i).personne.a_donne_justificatif_assurance
        nbre_assurance_validee +=1
      end

      respond_to do |format|
        format.html { redirect_to :back, :notice => nbre_assurance_validee.to_s + " assurances validées avec succés!"}
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, :notice => "Impossible de faire les validations"}
      end
    end
  end

  def export
    
    @personnes = Personne.all

    @personnes = @personnes.map{|p| p.serialize}

    respond_to do |format|
      format.xls do
        response.headers['Content-Disposition'] = 'attachment; filename="' +"export_personnes_"+Date.today.to_s+ '.xls"'
      end
    end
  end

private

  def set_personne
    @personne = Personne.find(params[:id])
  end

  def personne_params options=Hash.new

    perm_list=[:naissance,
              :phone,
              :adresse,
              :complement,
              :codepostal,
              :ville,
              :bucque,
              :fams,
              :promo,
              :pointure,
              :taille,
              :taillevetement_id,
              :tour_tete_id, 
              :niveau_ski_id,
              :pprenom,
              :pnom,
              :plienparente,
              :pphone,
              :padresse,
              :pcomplement,
              :pcodepostal,
              :pville,
              :commentaires,
              :nom,
              :prenom,
              :genre_id,
              :email,
              :user_id,
              :documentassurance,
              :typeresid_id,
              :commandes_attributes => [
                  :id,
                  :event_id,
                  :tbk_id,
                  :glisse_id,
                  :idlong,
                  :products_attributes => [:id,
                                           :nombre,
                                           :preference,
                                           :en_attente,
                                           :option_sup_id,
                                           :couleur_cadre,
                                           :couleur_verre,
                                           :option_id => [],
                                          ],
                  :product_personne_preferences_attributes => [
                                       :id,
                                       :product_id,
                                       :preference
                  ]
              ]]
    perm_list << :user_id if options[:registration] || current_user.admin?
    perm_list << :moderated if current_user.admin?

  params.require(:personne).permit( perm_list )
  end

  def sort_column
      Personne.column_names.include?(params[:sort]) ? params[:sort] : "nom"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end

# -*- encoding : utf-8 -*-
class PersonnesController < ApplicationController
  
  before_action :check_register_workflow, except: [:personne_infos, :update_personne_infos]
  before_action :set_personne, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  require 'will_paginate/array'

  def index
  	@personnes = Personne.all.order(sort_column + " " + sort_direction).paginate(:page => params[:page],:per_page => 50)
    authorize! :show, @personnes
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

    respond_to do |format|
      if @personne.save && @personne.update_attribute(:enregistrement_termine, true)
        format.html { redirect_to dashboard_user_url @personne.user, :notice => 'User was successfully updated.' }
        format.json { head :no_content }
      else
        @user=User.find(@personne.user_id)
        format.html { render 'users/new_personne' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end

  def personne_infos 
    set_personne
    authorize! :update, @personne
  end

  def update_personne_infos 
    set_personne
    # authorize! :update, @personne

    respond_to do |format|
      if (@personne.update_attributes(personne_params) && @personne.update_attribute(:enregistrement_termine, true))
        if @current_user.admin?
          format.html { redirect_to personnes_path , notice: 'User was successfully updated.' }
        else
          format.html { redirect_to dashboard_user_url @personne.user, notice: 'User was successfully updated.' }
        end
        format.json { head :no_content }
      else
        format.html { render action: 'personne_infos' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    set_personne
    authorize! :destroy, @personne
    user = @personne.user
    @personne.destroy
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
    @personnes = Personne.where(documentassurance: true).order("assurance_uptated_at").limit(5)
    authorize! :show, @personnes
    @to_moderate_nbr=Personne.where(moderated: [false, nil]).count
    @titre = "Personnes"
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
              :documentassurance]
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

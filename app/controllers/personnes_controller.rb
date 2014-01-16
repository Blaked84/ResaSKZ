class PersonnesController < ApplicationController
  
  before_action :check_register_workflow, except: [:personne_infos, :update_personne_infos]
  before_action :set_personne, only: [:show, :edit, :update, :destroy]

  def index
  	@personnes = Personne.all.sort_by{|a| a.nom}
    authorize! :show, @personnes
    @titre = "Personne"
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

  def personne_infos 
    set_personne
    authorize! :user_infos, @personne
  end

  def update_personne_infos 
    set_personne
    authorize! :user_infos, @personne

    respond_to do |format|
      if @personne.update_attributes(personne_params) && @personne.update_attribute(:enregistrement_termine, true)
        format.html { redirect_to dashboard_user_url @personne.user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'personne_infos' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

private

  def set_personne
    @personne = Personne.find(params[:id])
  end

  def personne_params
  params.require(:personne).permit( :naissance,
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
                                    :email
                                    )
  end

end

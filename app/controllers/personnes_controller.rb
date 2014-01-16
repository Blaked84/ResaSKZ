class PersonnesController < ApplicationController
  
  before_action :check_register_workflow, except: [:personne_infos, :update_personne_infos]

  def index
  	@personnes = Personne.all.sort_by{|a| a.nom}
    authorize! :show, @personnes
    @titre = "Personne"
  end

  def show
    authorize! :show, @personne
    @personne = Personne.find(params[:id])
    @personne.taillevetement ? @taillevetement = @personne.taillevetement.name : nil
    @commandes = @personne.commandes

  end

  def edit
  end

  def update
  end

  def personne_infos 
    set_personne

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

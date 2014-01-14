class PersonnesController < ApplicationController
  

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

  def referant_params
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

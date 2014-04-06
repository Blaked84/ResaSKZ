class ChambresController < ApplicationController
  
  autocomplete :personne, :nom, :full => true, :display_value => :nom_complet, extra_data: [:prenom, :nom]

  def index
    @chambres=Chambre.all
  end

  def import
  end

  def import_validate
  end

  def create
  end

  def assign
    @chambres=Chambre.all

  end

  def get_personnes_for
    @chambre=Chambre.find(params[:id])

    @personnes=@chambre.personnes_elligibles

  end

  def add_personne
    chambre=Chambre.find(params[:id])    
    personne=Personne.find(params[:pers_id])
    if chambre && chambre.add_personne(personne)
      render json: {id: personne.id, infos: personne.infos_completes}
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  def remove_personne
    chambre=Chambre.find(params[:id])    
    personne=Personne.find(params[:pers_id])
    if chambre && chambre.remove_personne(personne)
      render json: {id: personne.id, infos: personne.infos_completes}
    else
      render json: {}, status: :unprocessable_entity
    end
  end

end

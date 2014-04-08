class ChambresController < ApplicationController
  
  autocomplete :personne, :nom, :full => true, :display_value => :nom_complet, extra_data: [:prenom, :nom]

  def index
    @chambres=Chambres.all
  end

  def import
  end

  def import_validate
    authorize! :create, Chambre
    file=params[:file]
    if File.extname(file.original_filename) == '.csv'
      Chambre.import_from_csv(file)
      flash[:success] = I18n.t('chambre.success.import')
    else
      flash[:error] = I18n.t('chambre.error.wrong_ext')
    end
    redirect_to @chambres
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


    errors=chambre.check_errors(personne)
    warnings=chambre.check_warnings(personne)

    if errors.blank? && chambre && chambre.add_personne(personne)
      render json: {id: personne.id, infos: personne.infos_completes, message: warnings.first}
    else
      render json: {id: personne.id, infos: personne.infos_completes, message: errors.first}, status: :unprocessable_entity
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

class ChambresController < ApplicationController
  
  # Necessaire pour les permissions de l'autocomplete
  before_action :admin_only, only: [:autocomplete_personne_nom]
  autocomplete :personne, :nom, :full => true, :display_value => :nom_complet, extra_data: [:prenom, :nom]

  def index
    authorize! :read_admin, User
    @chambres=Chambre.all
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
    authorize! :read_admin, User
    
    @tbk_id = params[:tbk_id]
    @event_id = params[:event_id]
    @zone = params[:zone]
    @nom = params[:nom]

    @chambres=Chambre.all
    unless @nom.blank?
      @chambres=@chambres.select{|c| c.identifiant.upcase == @nom.upcase} 
      @tbk_id = nil
      @event_id = nil
      @zone = nil
    end
    @chambres=@chambres.where(tbk_id: @tbk_id) unless @tbk_id.blank?
    @chambres=@chambres.where(event_id: @event_id) unless @event_id.blank?
    @chambres=@chambres.where(zone: @zone) unless @zone.blank?

  end

  def get_personnes_for
    authorize! :read_admin, User
    @chambre=Chambre.find(params[:id])

    @personnes=@chambre.personnes_elligibles

  end

  def add_personne
    authorize! :read_admin, User
    chambre=Chambre.find(params[:id])    
    personne=Personne.find(params[:pers_id])


    errors=chambre.check_errors(personne)
    warnings=chambre.check_warnings(personne)

    errors_li=errors.map{|c| '<li>'+c+'</li>'}.join(' ')

    if errors.blank? && chambre && chambre.add_personne(personne)
      render json: {id: personne.id, infos: personne.infos_completes, message: warnings}
    else
      render json: errors_li.to_s, status: :unprocessable_entity
    end
  end

  def remove_personne
    authorize! :read_admin, User
    chambre=Chambre.find(params[:id])    
    personne=Personne.find(params[:pers_id])
    if chambre && chambre.remove_personne(personne)
      render json: {id: personne.id, infos: personne.infos_completes}
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  private

  def get_autocomplete_items(parameters)
    authorize! :read_admin, User
    super(parameters)
  end

end

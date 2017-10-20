class GammesController < ApplicationController
  before_action :set_gamme, only: [:edit, :update, :destroy]

  def index
    authorize! :show, @gammes
    @gammes = Gamme.all
  end

  def edit
    authorize! :read_admin, User    
  end

  def new
    authorize! :read_admin, User
    @gamme = Gamme.new
  end

  def create
    authorize! :read_admin, User
    @gamme = Gamme.new(gamme_params)

    respond_to do |format|
      if @gamme.save
        format.html { redirect_to gammes_path, notice: 'Vous venez de créer une nouvelle gamme.' }
        format.json { render action: 'show', status: :created, location: @gamme }
      else
        format.html { render action: 'new' }
        format.json { render json: @gamme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gammes/1
  # PATCH/PUT /gammes/1.json
  def update
    authorize! :read_admin, User
    respond_to do |format|
      if @gamme.update(gamme_params)
        format.html { redirect_to gammes_path, notice: 'La gamme a bien été modifiée.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @gamme.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_gamme
      @gamme = Gamme.find(params[:id])
    end

    def gamme_params
      params.require(:gamme).permit(:nom,:description)
    end   
   
end

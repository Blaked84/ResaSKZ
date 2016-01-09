class LitsController < ApplicationController
  before_action :set_lit, only: [:show, :edit, :update, :destroy]
  before_action :admin_only

  # GET /lits
  # GET /lits.json
  def index
    @lits = Lit.all
  end

  # GET /lits/1
  # GET /lits/1.json
  def show
  end

  # GET /lits/new
  def new
    @lit = Lit.new
  end

  # GET /lits/1/edit
  def edit
  end

  # POST /lits
  # POST /lits.json
  def create
    @lit = Lit.new(lit_params)

    respond_to do |format|
      if @lit.save
        format.html { redirect_to @lit, notice: 'Lit was successfully created.' }
        format.json { render action: 'show', status: :created, location: @lit }
      else
        format.html { render action: 'new' }
        format.json { render json: @lit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lits/1
  # PATCH/PUT /lits/1.json
  def update
    respond_to do |format|
      if @lit.update(lit_params)
        format.html { redirect_to @lit, notice: 'Lit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @lit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lits/1
  # DELETE /lits/1.json
  def destroy
    @lit.destroy
    respond_to do |format|
      format.html { redirect_to lits_url }
      format.json { head :no_content }
    end
  end

  def import
    authorize! :create, Lit
  end

  def import_validate
    authorize! :create, Lit
    file=params[:file]
    event_id=params[:event_id]
    if File.extname(file.original_filename) == '.csv'
      Lit.import_from_csv(file,Envent.find(event_id))
      flash[:success] = I18n.t('lits.success.import')
    else
      flash[:error] = I18n.t('lits.error.wrong_ext')
    end
    redirect_to backCham
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lit
      @lit = Lit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lit_params
      params.require(:lit).permit(:name, :chambre_id)
    end
end

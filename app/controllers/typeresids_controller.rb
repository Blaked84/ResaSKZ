class TyperesidsController < ApplicationController
  before_action :set_typeresid, only: [:show, :edit, :update, :destroy]
  before_action :admin_only

  # GET /typeresids
  # GET /typeresids.json
  def index
    authorize! :read_admin, User
    @typeresids = Typeresid.all
  end

  # GET /typeresids/1
  # GET /typeresids/1.json
  def show
    authorize! :read_admin, User

  end

  # GET /typeresids/new
  def new
    authorize! :read_admin, User
    @typeresid = Typeresid.new
  end

  # GET /typeresids/1/edit
  def edit
    authorize! :read_admin, User
  end

  # POST /typeresids
  # POST /typeresids.json
  def create
    authorize! :read_admin, User
    @typeresid = Typeresid.new(typeresid_params)

    respond_to do |format|
      if @typeresid.save
        format.html { redirect_to @typeresid, notice: 'Typeresid was successfully created.' }
        format.json { render action: 'show', status: :created, location: @typeresid }
      else
        format.html { render action: 'new' }
        format.json { render json: @typeresid.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /typeresids/1
  # PATCH/PUT /typeresids/1.json
  def update
    authorize! :read_admin, User
    respond_to do |format|
      if @typeresid.update(typeresid_params)
        format.html { redirect_to @typeresid, notice: 'Typeresid was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @typeresid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /typeresids/1
  # DELETE /typeresids/1.json
  def destroy
    authorize! :read_admin, User
    @typeresid.destroy
    respond_to do |format|
      format.html { redirect_to typeresids_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_typeresid
      @typeresid = Typeresid.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def typeresid_params
      params[:typeresid]
    end
end

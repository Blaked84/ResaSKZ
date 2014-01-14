class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_workflow_register_user, only: [:dashboard]

  

  # GET /users
  # GET /users.json
  def index
    authorize! :index, User
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    authorize! :index, @user
  end

  # GET /users/new
  def new
    @user = User.new
    authorize! :new, @user
  end

  # GET /users/1/edit
  def edit
    authorize! :edit, @user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    authorize! :create, @user

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    authorize! :update, @user
    respond_to do |format|
      if @user.update(user_params)

        @user.referant.sync_from_user(@user) if @user.referant

        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    authorize! :destroy, @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def cgu
    set_user
    authorize! :cgu, @user
    redirect_to dashboard_user_path(@user) if @user.cgu_accepted
  end

  def cgu_accept
    set_user
    authorize! :cgu, @user

    redirect_to dashboard_user_path(@user) if @user.cgu_accepted

    @user.cgu_accepted=true if params[:cgu_accepted]

    if @user.save
      if @user.cgu_accepted
        return redirect_to user_infos_user_url @user.id
      else
        render action: 'cgu'
      end
    else
      render action: 'cgu'
    end
  end


  def user_infos
    set_user
    @personne = @user.referant
    authorize! :user_infos, @user
  end

  def update_user_infos
    set_user
    @personne = @user.referant
    authorize! :user_infos, @user

    @user.inscription_terminee = true

    respond_to do |format|
      if @user.update(user_params) && @user.referant.update_attributes(referant_params) && @user.update_attribute(:inscription_terminee, true) && @personne.update_attribute(:enregistrement_termine, true)

        @user.referant.sync_from_user(@user) if @user.referant
        format.html { redirect_to dashboard_user_url @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'user_infos' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end  

  def dashboard
    set_user
    authorize! :dashboard, @user

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params_pub
      params.require(:user).permit(:first_name, :last_name, :gender)
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :gender, :uid)
    end

    def referant_params
      params.require(:user).require(:personne).permit(:naissance,
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
                                                      :commentaires
                                                      )
    end

    def check_workflow_register_user
      check_register_workflow(current_user)
    end
end

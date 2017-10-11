# -*- encoding : utf-8 -*-
class UsersController < ApplicationController


  before_action :check_register_workflow, except: [:cgu, :cgu_accept, :user_infos, :update_user_infos]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  

  # GET /users
  # GET /users.json
  def index
    @users = User.where(moderated: true).paginate(:page => params[:page],:per_page => 50)
    authorize! :show, @users
    @to_moderate_nbr = User.where(moderated: [false, nil]).count
  end

  def to_moderate
    @users = User.where(moderated: [false, nil]).paginate(:page => params[:page],:per_page => 50)

    authorize! :show, @users

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
    @roles = Hash[Role.all.map{|r| [r.name, @user.has_role?(r.name)]}]
  end

  # GET /users/1/edit
  def edit
    authorize! :edit, @user
    @roles = Hash[Role.all.map{|r| [r.name, @user.has_role?(r.name)]}]
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    authorize! :create, @user

    @roles=params[:roles]
    #raise @roles.ro_s



    respond_to do |format|
      if @user.save
        pers = @user.personnes.new(
        :prenom => @user.first_name,
        :nom => @user.last_name,
        :email => @user.email,
        enregistrement_termine: false
        )

        pers.genre = Genre.from_cas(@user.gender)
        if pers.save!(:validate=>false)
          @user.update_attribute(:referant_id,pers.id)
          format.html { redirect_to @user, notice: 'Compte créé!' }
          format.json { render action: 'show', status: :created, location: @user }
        else
          format.html { redirect_to @user, alert: 'Le user a été créé mais un problème à eu lieu lors de la sauveragrde de la personne.' }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
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

    @roles=params[:roles].to_a
    
    respond_to do |format|
      if @user.update(user_params)

        @user.referant.sync_from_user(@user) if @user.referant

        
        if current_user.admin?
          @user.referant.sync_from_user(@user) if @user.referant
          Role.all.each{|r| @user.remove_role r.name}

            @roles.each do |r,ok|
              @user.add_role r if ok
            end
        end

        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else

        @roles = Hash[Role.all.map{|r| [r.name, @user.has_role?(r.name)]}]

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

    if @user.save(:validate => false)
      if @user.cgu_accepted
        return redirect_to user_infos_user_url @user.id
      else
        flash.now[:alert] = "Vous devez lire et accepter les CGU avant de pouvoir continuer"
        render action: 'cgu'
      end
    else
      flash.now[:alert] = "Une erreur a eu lieu lors de la sauvegarde. Si l'erreur persiste, contactez un adminnistrateur"
      render action: 'cgu'
    end
  end


  def user_infos
    set_user
    redirect_to dashboard_user_path(@user) if @user.inscription_terminee
    @personne = @user.referant
    @roles = Hash[@user.roles.map{|r| [r.name, true]}]
    authorize! :user_infos, @user
  end

  def update_user_infos
    set_user
    redirect_to dashboard_user_path(@user) if @user.inscription_terminee
    @personne = @user.referant
    authorize! :user_infos, @user

    @personne.type_pers ||= "Pec's"
   
   # parce que le cas ne renvoit pas toujours le genre. Et encore une fois, c'est un hotfix pas très beau mais ça devrait faire l'affaire
    if @user.gender.nil?
      @user.gender="male"
      @user.save!(:validate=>false)
    end

    respond_to do |format|

      if @user.update(user_params_pub) && @personne.sync_from_user(@user, without_save: true) && @personne.update_attributes(referant_params)  && @personne.update_attribute(:enregistrement_termine, true) && @user.update_attribute(:inscription_terminee, true)
      # if @user.update(user_params_pub) && @personne.update_attributes(referant_params)  && @personne.update_attribute(:enregistrement_termine, true) && @user.update_attribute(:inscription_terminee, true)

        if current_user.admin?
          @user.referant.sync_from_user(@user) if @user.referant
          Role.all.each{|r| @user.remove_role r.name}

            @roles.each do |r,ok|
              @user.add_role r if ok
            end
        end
        sign_in(@user, :bypass => true)
        format.html { redirect_to dashboard_user_url @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else

        @personne.assign_attributes(referant_params)
        @personne.valid?

        @personne.errors.full_messages.each do |m|
          @user.errors.add(:base, m)
        end

        format.html { render action: 'user_infos' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end  

  def new_personne
    set_user
    @personne = @user.personnes.new
    authorize! :create, @personne
  end

  def parrainer
    @parrain=User.find(params[:id])
    authorize! :parrainer, @parrain
    @user=@parrain.filleuls.new
    @roles = Hash[@user.roles.map{|r| [r.name, true]}]
  end

  def register
    @token = params[:token]
    @token_account = Preregistration.find_by(token: @token)
    #on vérifie que le token existe et n'a pas été utilisé
    unless @token_account == nil || @token_account.used?
      #authorize! :parrainer, @parrain
      @user=User.new
      @user.email = @token_account.email
      @roles = Hash[@user.roles.map{|r| [r.name, true]}]
    else
      respond_to do |format|
        format.html { redirect_to root_path, alert: 'Inscription déjà réalisée par ce lien' }
      end
    end 

  end

  def create_register
    # @parrain=User.find(params[:id])
    # authorize! :parrainer, @parrain
    @token = params[:token]
    @token_account = Preregistration.find_by(token: @token)
    @user=User.new(user_params_pub(:registration => true))
    @roles = Hash[@user.roles.map{|r| [r.name, true]}]

    @user.moderated = true #if current_user.admin?
    respond_to do |format|
      if @user.save
        unless current_user.nil?
          if current_user.admin?
            @user.referant.sync_from_user(@user) if @user.referant
            Role.all.each{|r| @user.remove_role r.name}

            @roles.each do |r,ok|
              @user.add_role r if ok
            end
          end
        end

        pers = @user.personnes.new(
        :prenom => @user.first_name,
        :nom => @user.last_name,
        :email => @user.email,
        :moderated => true,
        enregistrement_termine: false
        )

        pers.type_pers = "Gadz"

        #pers.genre = Genre.from_cas(@user.gender)   
        if pers.save(:validate=>false)
          @user.update_attribute(:referant_id,pers.id)
          # indique que le token a été utilisé
          @token_account.set_used

          format.html { redirect_to root_path, notice: 'Nouveau compte créé!' }
        else
          format.html { redirect_to root_path, alert: 'Le user a été créé mais un problème à eu lieu lors de la sauveragrde de la personne.' }
        end
      else
        format.html { render action: 'register' }
      end
    end

  end

  def create_parrainer
    @parrain=User.find(params[:id])
    authorize! :parrainer, @parrain
    @user=@parrain.filleuls.new(user_params_pub(:registration => true))
    @roles = Hash[@user.roles.map{|r| [r.name, true]}]

    @user.moderated = true if current_user.admin?

    

    respond_to do |format|
      if @user.save


        if current_user.admin?
          @user.referant.sync_from_user(@user) if @user.referant
          Role.all.each{|r| @user.remove_role r.name}

            @roles.each do |r,ok|
              @user.add_role r if ok
            end
        end

        pers = @user.personnes.new(
        :prenom => @user.first_name,
        :nom => @user.last_name,
        :email => @user.email,
        enregistrement_termine: false
        )

        pers.type_pers = "Pec's"

        pers.genre = Genre.from_cas(@user.gender)   
        if pers.save(:validate=>false)
          @user.update_attribute(:referant_id,pers.id)
          format.html { redirect_to dashboard_user_path(@parrain), notice: 'User was successfully created.' }
        else
          format.html { redirect_to dashboard_user_path@parrain, alert: 'Le user a été créé mais un problème à eu lieu lors de la sauveragrde de la personne.' }
        end
      else
        format.html { render action: 'parrainer' }
      end
    end

  end

  def dashboard
    set_user
    authorize! :dashboard, @user
    @commandes=@user.personnes.map{ |p| p.commandes}.flatten
    @events = Event.all
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params_pub opts=Hash.new

      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
      
      permit_list = [:first_name,
                    :last_name,
                    :gender,
                    :current_password,
                    :password,
                    :password_confirmation]
      permit_list += [:email] if opts[:registration] || current_user.admin?
      unless current_user.nil?
        permit_list += [:uid,:moderated] if current_user.admin?
      end

      params.require(:user).permit( permit_list)

    end

    def user_params

      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
      params.require(:user).permit(:first_name, :last_name, :gender, :uid, :email, :password, :password_confirmation,:moderated)
    end

    def referant_params
      params.fetch(:user).require(:personne).permit(:naissance,
                                                      :phone,
                                                      :adresse,
                                                      :complement,
                                                      :codepostal,
                                                      :ville,
                                                      :bucque,
                                                      :genre_id,
                                                      :fams,
                                                      :promo,
                                                      :taille,
                                                      :pointure,
                                                      :taillevetement_id,
                                                      :tour_tete_id,
                                                      :niveau_ski_id,
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
      set_user
      check_register_workflow(@user) unless @user.id != current_user.id
    end
end

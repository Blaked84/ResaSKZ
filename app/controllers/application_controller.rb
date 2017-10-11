#encoding: utf-8
class ApplicationController < ActionController::Base
  
  before_filter :check_admin_mode
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    if current_user.nil?
      session[:next] = request.fullpath
      puts session[:next]
      redirect_to new_user_session_url, :alert => "Vous devez vous connecter pour continuer."
    else
      #render :file => "#{Rails.root}/public/403.html", :status => 403
      if request.env["HTTP_REFERER"].present?
        redirect_to :back, :alert => exception.message
      else
        redirect_to root_url, :alert => exception.message
      end
    end
  end

  def after_sign_in_path_for(resource)
    if current_user
      if current_user.admin?
        admin_index_path
      else
        dashboard_user_path(current_user)
        #request.env['omniauth.origin'] || stored_location_for(resource)
      end
    else
      root_path
    end
  end


  protected
 
  def admin_only
    authorize! :read_admin, User
  end

  def check_register_workflow

    if user=current_user
      mod = check_moderated
      return mod if mod
      unless user.admin?

        # return redirect_to cgu_user_url(user), :notice => "Vous devez lire et accepter les CGU avant de pouvoir continuer" unless user.cgu_accepted

        return redirect_to user_infos_user_url(user), :notice => "Veuillez renseigner vos informations d'inscription avant de continuer" unless user.inscription_terminee

        user.personnes.each do |p|
          return redirect_to personne_infos_personne_url(p), :alert => "Vous n'avez pas fini de remplir vos informations d'inscription" unless p.enregistrement_termine
        end

        nil
      end

    end

  end

  def check_admin_mode
    if Configurable[:mode_maintenance] && controller_name != 'devise/sessions' && controller_name != 'home' && !current_user.nil?
       unless current_user.has_role?(:admin) || current_user.has_role?(:gorgu)
         cookies.delete(:secureusertokens)
         reset_session
         redirect_to root_path
       end
       
    end
  end

  def check_moderated
    if current_user
      unless current_user.moderated
        signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
        return redirect_to root_path, alert: "Votre compte n'a pas encore été accépté par les administrateurs"
    end
    end

    nil
  end

  def ip
   request.env['HTTP_X_FORWARDED_FOR'] || request.remote_ip 
  end
end

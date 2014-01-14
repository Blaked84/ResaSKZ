class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  rescue_from CanCan::AccessDenied do |exception|
    if current_user.nil?
      session[:next] = request.fullpath
      puts session[:next]
      redirect_to new_user_session_url, :alert => "You have to log in to continue."
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
    current_user ? dashboard_user_path(current_user) : root_path
  end


  protected

  def check_register_workflow(user)

    return redirect_to new_user_session_url, :alert => "You have to log in to continue." unless user

    return redirect_to cgu_user_url(user), :alert => "Vous n'avez pas accepte les CGU" unless user.cgu_accepted

    return redirect_to user_infos_user_url(user), :alert => "Vous n'avez pas fini de remplir vos information d'inscription" unless user.inscription_terminee

    user.personnes.each do |p|
      return redirect_to personne_infos_personne_url(p), :alert => "Vous n'avez pas fini de remplir vos information d'inscription" unless p.enregistrement_termine
    end

    nil

  end

end

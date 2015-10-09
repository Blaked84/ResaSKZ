class HomeController < ApplicationController
	layout "landing"
  def index
  	@maintenance=Configurable[:mode_maintenance]

  	resource
  	resource_name
  	devise_mapping

  	redirect_to dashboard_user_path(current_user) if current_user

  	# flash.now[:notice] = 'Ceci est un message \'notice\'.'
  	# flash.now[:alert] = 'Ceci est un message \'alert\'.'

  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end

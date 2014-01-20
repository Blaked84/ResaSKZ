class HomeController < ApplicationController
	layout "landing"
  def index
  	@maintenance=Configurable[:mode_maintenance]

  	redirect_to dashboard_user_path(current_user) if current_user

  	# flash.now[:notice] = 'Ceci est un message \'notice\'.'
  	# flash.now[:alert] = 'Ceci est un message \'alert\'.'

  end
end

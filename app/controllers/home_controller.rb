class HomeController < ApplicationController
	layout "landing"
  def index
  	redirect_to dashboard_user_path(current_user) if current_user
  end
end

class Admin::ConfigurablesController < ApplicationController

  # include the engine controller actions
  include ConfigurableEngine::ConfigurablesController

  # add your own filter(s) / layout
  before_filter :protect_my_code
  

 def protect_my_code
 	#authorize! :voir_page_admin, User
 end

end

class EventsController < ApplicationController

  before_action :check_register_workflow
  
  load_and_authorize_resource

  def index
  	@events = @events.sort_by{|a| a.updated_at}
    authorize! :show, @personnes

  end

  def show
    authorize! :show, @personnes

  end
end

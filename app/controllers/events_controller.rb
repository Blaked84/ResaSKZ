class EventsController < ApplicationController
  
  load_and_authorize_resource

  def index
  	@events = @events.sort_by{|a| a.updated_at}
  end

  def show

  end
end

class EventController < ApplicationController
  def index
  	@event = Event.all.sort_by{|a| a.updated_at}
  end

  def show
 	@event = Event.find(params[:id])

  end
end

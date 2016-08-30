class EventController < ApplicationController
  before_action :set_event, only: [:show, :update, :edit, :destroy]
  def index
    @events = Event.all
  end

  def new
    @new_event = Event.new
    year = params[:year]
    month = params[:month]
    day = params[:day]

    if year && month && day
      t = "#{year}/#{month}/#{day}"
      @new_event.start_at = t.to_date
    else
      @new_event.start_at = Date.today
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_details)
        format.html { redirect_to action: 'index' }
      else
        format.html { redirect_to action: 'new' }
      end
    end
  end

  def edit
  end

  def show
  end

  def destroy
    @event.destroy
    redirect_to action: 'index'
  end

  def create
    event = Event.new(event_details)
    respond_to do |format|
      if event.save
        format.html { redirect_to action: 'index' }
      else
        format.html { redirect_to action: 'new' }
      end
    end
  end

  private

  def event_details
    params.require(:event).permit(:name, :start_at, :end_at)
  end

  def set_event
    @event = Event.find_by(id: params[:id])
    redirect_to action: 'index' unless @event
  end
end

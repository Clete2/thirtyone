class WorkScheduleController < ApplicationController
  before_action :set_work_schedule, only: [:update, :edit, :show, :destroy]
  before_action :authorize_work_schedule

  @@date_format = '%Y-%m-%d'
  @@datetime_format = @@date_format +' %H:%M:%S %:z'

  @@staff_invalid_error = 'Please enter a valid name'

  def index
    @work_schedules = WorkSchedule.all
  end

  def new
    @work_schedule = WorkSchedule.new
    @work_schedule.start_at = Time.now.change(hour: 8, min: 0)
    @work_schedule.end_at = Time.now.change(hour: 16, min: 0)

    @users = User.where.not(person: nil)
  end

  def update
    populate_work_schedule()
  end

  def edit
  end

  def show
    @users = User.all
  end

  def destroy
    @work_schedule.destroy
    respond_to do |format|
      format.html { redirect_to calendar_index_url }
      format.json { head :no_content }
    end
  end

  def create
    @work_schedule = WorkSchedule.new()
    populate_work_schedule()
  end

  private
  def populate_work_schedule
    @work_schedule.note = params[:work_schedule][:note]
    # Grab the zone from the user's input so that we can append it to the date.
    # We take the end of the day so that if DST status changed that day it will pick up the new timezone offset.
    @zone = ' '+ DateTime.strptime(params[:work_schedule][:start_at][0..9], @@date_format).end_of_day.in_time_zone.zone
    # Now append it to each of the dates.
    @work_schedule.start_at = DateTime.strptime(params[:work_schedule][:start_at] + @zone, @@datetime_format)
    @work_schedule.end_at = DateTime.strptime(params[:work_schedule][:end_at] + @zone, @@datetime_format)

    if params[:user_id] != '' and User.find(params[:user_id])
      @work_schedule.user_id = params[:user_id]
      respond_to do |format|
        if @work_schedule.save
          format.html { redirect_to controller: 'calendar', action: 'index' }
        else
          format.html { redirect_to action: 'new', alert: @@staff_invalid_error }
        end
      end
    else
      @users = User.all
      flash.now[:alert] = @@staff_invalid_error
      render action: 'new'
    end
  end

  def set_work_schedule
    @work_schedule = WorkSchedule.find_by(id: params[:id])
    redirect_to action: 'index' unless @work_schedule
  end

  def authorize_work_schedule
    @work_schedule ? (authorize @work_schedule) : (authorize :work_schedule)
  end
end

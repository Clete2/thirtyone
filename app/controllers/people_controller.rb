class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :init
  before_action :authorize_person

  def init
    @errors = []
  end

  # GET /people
  # GET /people.json
  def index
    @people = Person.all
    @new_person = Person.new
    @all_states = State.all
  end

  # GET /people/search
  # GET /people/search.json
  def search
    @people = PeopleSearch.search(params)
    respond_to do |format|
      format.html {
        if params[:ajax]
          render partial: 'search_results'
        else
          @new_person = Person.new
          @search_string = params[:search] ? params[:search].join(' ') : ''
          render action: 'index'
        end
      }
      format.json { render action: 'index.json' }
    end
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @household = @person.household
  end

  # GET /people/new
  def new
    @person = Person.new
    @all_states = State.all
    @new_household = Household.new
    if params[:search]
      @person.firstname, @person.lastname = params[:search].split(' ', 2)
    end

    if params[:household_id]
      @person.household = Household.find_by(id: params[:household_id])
    elsif params[:household_data]
      household_data = JSON.load(params[:household_data])
      address_data = household_data['address']
      @new_household.address = Address.new(address_data)
    end

    @person.household ||= @new_household
  end

  # GET /people/1/edit
  def edit
    @household = @person.household
    @all_states = State.all
    @is_user = !@person.user.nil?
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new
    manage_create_or_update
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    manage_create_or_update(true)
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url }
      format.json { head :no_content }
    end
  end

  def redirect_to_url
    if params[:redirect_to_url]
      return params[:redirect_to_url]
    end
  end

  helper_method :redirect_to_url

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_person
    @person = Person.find_by(id: params[:id])
    @all_states = State.all
    redirect_to action: 'index' unless @person
  end

  def authorize_person
    @person ? (authorize @person) : (authorize :person)
  end

  def manage_create_or_update(is_update = false)
    @person ||= Person.new
    psv = PeopleSubmissionValidator.new(params)

    respond_to do |format|
      if psv.process(@person)
        @person.user.send_new_account_instructions unless(@person.user.nil? || is_update)
        # Redirect to the edit user page if they are creating a new user
        url = edit_user_path(@person.user) if params[:create_user] == 'yes'
        url ||= params[:redirect_to_url] || @person
        msg = is_update ? 'updated' : 'created'
        format.html { redirect_to url, notice: "Person was successfully #{msg}." }
        if is_update
          format.json { head :no_content }
        else
          format.json { render action: 'show', status: :created, location: @person }
        end
      else
        format.html { render action: is_update ? 'edit' : 'new' }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end
end

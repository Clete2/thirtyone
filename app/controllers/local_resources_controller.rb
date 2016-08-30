class LocalResourcesController < ApplicationController
  before_action :set_local_resource, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authorize_local_resource

  # GET /local_resources
  # GET /local_resources.json
  def index
    @local_resources = LocalResource.all
    @local_resource_categories = LocalResourceCategory.all
  end

  # GET /local_resources/1
  # GET /local_resources/1.json
  def show
  end

  def search
    @local_resources, @local_resource_categories = LocalResourceSearch.search(params)
    respond_to do |format|
      format.html {
         render partial: 'search_results'
      }
      format.json { render action: 'index.json' }
    end
  end

  # GET /local_resources/new
  def new
    @local_resource = LocalResource.new
    @address = Address.new
  end

  # GET /local_resources/1/edit
  def edit
    @state_id = @local_resource.address.state_id
    @local_resource_categories = @local_resource.local_resource_categories.map(&:id)
  end

  # POST /local_resources
  # POST /local_resources.json
  def create
    @local_resource = LocalResource.new(local_resource_params)

    # Make the address nil if the user didn't enter anything. Otherwise, set the state.
    if params[:local_resource][:address_attributes][:line1].blank?
      @local_resource.address = nil
    else
      update_state
    end

    update_local_resource_categories

    respond_to do |format|
      if @local_resource.save
        format.html { redirect_to @local_resource, notice: 'Local resource was successfully created.' }
        format.json { render action: 'show', status: :created, location: @local_resource }
      else
        # Set the address if we set it to nil above
        @address = Address.new if @address.nil?
        format.html { render action: 'new' }
        format.json { render json: @local_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /local_resources/1
  # PATCH/PUT /local_resources/1.json
  def update
    respond_to do |format|
      if @local_resource.update(local_resource_params)
        update_state
        update_local_resource_categories
        format.html { redirect_to @local_resource, notice: 'Local resource was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @local_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /local_resources/1
  # DELETE /local_resources/1.json
  def destroy
    @local_resource.destroy
    respond_to do |format|
      format.html { redirect_to local_resources_url }
      format.json { head :no_content }
    end
  end

  private
    def update_state
      @local_resource.address.state = State.find(params[:local_resource][:address_attributes][:state])
    end

    def update_local_resource_categories
      @local_resource.local_resource_categories = []

      params[:local_resource][:local_resource_categories].each do |local_resource_category_id|
        next if local_resource_category_id.blank?
        @local_resource_category = LocalResourceCategory.find(local_resource_category_id)
        @local_resource.local_resource_categories << @local_resource_category
        @local_resource.save
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_local_resource
      @local_resource = LocalResource.find_by(id: params[:id])
      redirect_to local_resources_url unless @local_resource
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def local_resource_params
      params.require(:local_resource).permit(:contact_name, :business_name, :phone, :phone_ext, :email, :url,
                                             address_attributes: [:line1, :line2, :city, :zip])
    end

    def authorize_local_resource
      authorize :local_resource
    end
end

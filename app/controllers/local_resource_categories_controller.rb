class LocalResourceCategoriesController < ApplicationController
  before_action :set_local_resource_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authorize_local_resource_category

  # GET /local_resource_categories
  # GET /local_resource_categories.json
  def index
    @local_resource_categories = LocalResourceCategory.all
  end

  # GET /local_resource_categories/1
  # GET /local_resource_categories/1.json
  def show
  end

  # GET /local_resource_categories/new
  def new
    @local_resource_category = LocalResourceCategory.new
  end

  # GET /local_resource_categories/1/edit
  def edit
  end

  # POST /local_resource_categories
  # POST /local_resource_categories.json
  def create
    @local_resource_category = LocalResourceCategory.new(local_resource_category_params)

    respond_to do |format|
      if @local_resource_category.save
        format.html { redirect_to @local_resource_category, notice: 'Local resource category was successfully created.' }
        format.json { render action: 'show', status: :created, location: @local_resource_category }
      else
        format.html { render action: 'new' }
        format.json { render json: @local_resource_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /local_resource_categories/1
  # PATCH/PUT /local_resource_categories/1.json
  def update
    respond_to do |format|
      if @local_resource_category.update(local_resource_category_params)
        format.html { redirect_to @local_resource_category, notice: 'Local resource category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @local_resource_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /local_resource_categories/1
  # DELETE /local_resource_categories/1.json
  def destroy
    @local_resource_category.destroy
    respond_to do |format|
      format.html { redirect_to local_resource_categories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_local_resource_category
      @local_resource_category = LocalResourceCategory.find_by(id: params[:id])
      redirect_to local_resource_categories_url unless @local_resource_category
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def local_resource_category_params
      params.require(:local_resource_category).permit(:name)
    end

    def authorize_local_resource_category
      authorize :local_resource_category
    end
end

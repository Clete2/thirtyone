class RolesController < ApplicationController
  before_action :set_role, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authorize_role

  # GET /roles
  # GET /roles.json
  def index
    @roles = Role.all
  end

  # GET /role/1
  # GET /role/1.json
  def show
  end

  # GET /roles/new
  def new
    @role = Role.new
  end

  # GET /roles/1/edit
  def edit
  end

  # GET /roles/bulk
  def bulk_assign_new
    @roles = Role.all
    @users = User.all
  end

  # POST /roles/bulk
  def bulk_assign_create
    users = confirm_bulk_assign('users', User)
    roles = confirm_bulk_assign('roles', Role)

    if users && roles
      users.each{ |user| user.roles = roles }
      flash[:notice] = 'Users updated successfully'
    else
      flash[:notice] = 'An error occurred. Try again'
    end

    redirect_to action: 'bulk_assign_new'
  end

  # POST /roles
  # POST /roles.json
  def create
    @role = Role.new(role_params)
    respond_to do |format|
      set_role_permission
      if @role.permissions != 0 && @role.save
        format.html { redirect_to @role, notice: 'Role was successfully created.' }
        format.json { render action: 'show', status: :created, location: @role }
      else
        flash[:notice] = " <<< Please Enter a name and select at least one checkbox. >>> "
        format.html { render action: 'new' }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roles/1
  # PATCH/PUT /roles/1.json
  def update
    respond_to do |format|
      set_role_permission
      if @role.update(role_params)
        format.html { redirect_to @role, notice: 'Role was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    @role.destroy
    respond_to do |format|
      format.html { redirect_to roles_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_role
    @role = Role.find_by(id: params[:id])
    redirect_to action: 'index' unless @role
  end

  def set_role_permission
    @role.permissions = params[:PermGrp].inject(0){ |sum, num| sum + num.to_i } if params[:PermGrp]
  end

  def confirm_bulk_assign(type, klass)
    return unless params[type]
    result = params[type].map{ |id| klass.find_by(id: id) }
    result.reject!(&:nil?).empty? ? nil : result
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def role_params
    params.require(:role).permit(:PrmGrp, :name, :permissions)
  end

  def authorize_role
    @role ? (authorize @role) : (authorize :role)
  end
end

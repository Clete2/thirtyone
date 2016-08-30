class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :cancel_pending_email_change, :send_confirmation_email, :confirm_email_change, :show_person]
  before_action :authenticate_user!, except: [:confirm_email_change]
  before_action :authorize_user
  before_action :set_common_vars, only: [:edit, :update]

  # GET /user
  # GET /user.json
  def index
    @people = Person.includes(:user).where.not(users: {id: nil})
    @new_person = Person.new
    @all_states = State.all
    render 'people/index'
  end

  # GET /user/1/edit
  def edit
  end

  # PATCH/PUT /user/1
  # PATCH/PUT /user/1.json
  def update
    if @user.update user_params
      conditionally_notify_email

      conditionally_re_login_user

      respond_to do |format|
        format.html { redirect_to @user.person, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /user/1
  # Redirect to the person show page
  def show_person
    redirect_to @user.person
  end

  # This is an AJAX only method, there is no page to be displayed.  It just invokes an action.
  def send_confirmation_email
    if @user.has_pending_email_change?
      @user.send_confirmation_email
    end
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  # This is an AJAX only method, there is no page to be displayed.  It just invokes an action.
  def cancel_pending_email_change
    @user.cancel_pending_email_change
    @user.save
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  # This page does not require authentication
  def confirm_email_change
    if @user.has_pending_email_change?
      if params[:confirmation_token] != @user.reset_email_token
        render 'users/email/invalid_token'
        return
      end
      @user.confirm_email_change
      if @user.save
        @user.person.email = @user.email
        @user.person.save
      end
      if not @user.valid? or not @user.person.valid?
        @errors = []
        @errors += @user.errors.full_messages
        @errors += @user.person.errors.full_messages
      end
      render 'users/email/confirm_email_change'
      return
    end
  else
    render 'users/email/invalid_token'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_by(id: params[:id])
    redirect_to users_url unless @user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    # Remove password fields if it is blank because the user is not trying to change the password
    # Or if the user is not allowed to edit the password
    if params[:user][:password].blank? || !can_edit_password
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    # Only admins can edit user roles
    if current_user.has_access?(PERM_ADMIN)
      params.require(:user).permit(:email, :password, :password_confirmation, :role_ids => [])
    else
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  end

  def can_edit_password
    current_user.has_access?(PERM_ADMIN) || current_user == @user
  end

  # Notifies the user by email if they opted to change their email
  def conditionally_notify_email
    if user_params[:email] != @user.email
      @user.send_confirmation_email
      flash.notice = 'Email successfully updated. Check your new e-mail for instructions to confirm'
    end
  end

  # Logs the user back in if they opted to change their password and the logged in user is the same user being edited
  def conditionally_re_login_user
    if user_params[:password] && user_params[:password_confirmation] && current_user == @user
      sign_in @user, :bypass => true
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user
    @user ? (authorize @user) : (authorize :user)
  end

  def set_common_vars
    @can_edit_password = can_edit_password
    @disable_roles = !current_user.has_access?(PERM_ADMIN)
  end
end

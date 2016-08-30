require 'uri'
class HouseholdController < ApplicationController
  before_action :authenticate_user!
  before_action :set_household, only: [:show, :edit, :update, :destroy, :merge_select, :merge_select_fields, :merge]
  before_action :set_merge_household, only: [:merge, :merge_select_fields]
  before_action :authorize_household

  def index
    @households = Household.all
    if params[:ajax]
      render partial: 'search'
    end
  end

  def create
    @household = Household.new
    @household.address = Address.new(address_params)

    respond_to do |format|
      if @household.valid? and @household.errors.empty?
        if params[:redirect_to_url]
          format.html {redirect_to params[:redirect_to_url]}
        else
          household_data = {"address" => {"line1"    => @household.address.line1,
                                          "line2"    => @household.address.line2,
                                          "city"     => @household.address.city,
                                          "state_id" => @household.address.state_id,
                                          "zip"      => @household.address.zip}}

          format.html { redirect_to "#{new_person_url}?household_data=#{URI.encode(JSON.dump(household_data))}", notice: 'Please complete this form to add a head of household' }
          format.json { render action: 'show', status: :created, location: @household }
        end
      else
        format.html { render action: 'new' }
        format.json { render json: @household.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    respond_to do |format|
      format.html {
        if params[:ajax]
          render :partial => 'show', person_select: true
        else
          render 'show'
        end
      }
      #format.json { render action: 'show.json' }
    end
  end

  def edit
    respond_to do |format|
      format.html {
        if params[:ajax]
          render :partial => 'edit'
        else
          render 'edit'
        end
      }
    end
  end

  def update
    @household.address.update(address_params)
    @household.update(household_limit_params)

    respond_to do |format|
      format.html { redirect_to @household, notice: 'Household was successfully updated.' }
    end
  end

  # DELETE /household/1
  # DELETE /household/1.json
  def destroy
    @household.destroy
    respond_to do |format|
      format.html { redirect_to households_url, notice: 'Household was deleted.' }
      format.json { head :no_content }
    end
  end

  def new
    @household = Household.new
    @household.address = Address.new
    @household.address.state = State.most_used_state
    @all_states = State.all
    respond_to do |format|
      format.html {
        if params[:ajax]
          render :partial => 'new'
        else
          render 'new'
        end
      }
      #format.json { render action: 'new.json' }
    end
  end

  # Used for selecting a household and associating it with a person
  def select
    @households = Household.all
    if params[:ajax]
      render partial: 'select'
    end
  end

  def merge_select
    @households = Household.where('id != ?', @household.id).all

    render 'merge', locals: {action: 'merge_household'}
  end

  def merge_select_fields
  end

  def merge
    success = false
    @household.transaction do
      @household.address_id = params[:address_id]
      @household.person_id = params[:head_id]
      members = Person.where(id: params[:member_ids])
      if not params[:member_ids].include?(params[:head_id])
        @household.errors.add(:person, 'You cannot delete the same user you have selected as the head of household')
        raise ActiveRecord::Rollback
      end
      @household.members = members
      success = @household.save
      @merge_household.delete
    end
    if success
      respond_to do |format|
        format.html { redirect_to @household, notice: 'Household was successfully merged.' }
      end
    else
      # Reset household and merge_household back to original state
      # Without this the @household attribute would show a partially
      # merged state, while @merge_household would show it's original state
      #
      # The goal is to never hit this server side error, but have Javascript that
      # prevents all errors.  This page is completely checkbox and radio button
      # operated.  So javascript should be able to catch most potential errors
      # ahead of time.
      errors = @household.errors
      set_household
      set_merge_household

      # Need to set the errors on @household for display purposes
      errors.each do |attr, msg|
        @household.errors.add(attr, msg)
      end
      respond_to do |format|
        format.html {
          render 'merge_select_fields'
        }
      end
    end
  end

  def search
    wild_card_query_fields = %w(people.firstname people.lastname)
    sql_params = []
    sql_where = ''

    if (params[:search])

      rowlimit = params[:rowlimit] || 10
      search_keys = JSON.parse(params[:search]).to_a

      wild_card_query_fields.each do |field|
        search_keys.each do |key|
          sql_where += ' OR ' if sql_where != ''
          sql_where += "#{field} LIKE ?"
          sql_params.push("#{key}%")
        end
      end

      @households = Household.joins(:person).where(sql_where, *sql_params).order('people.lastname').first(rowlimit.to_i)

    else
      @households = Household.all
    end
    #@people = Person.where("firstname LIKE ? #{sql_conditional} lastname LIKE ?", firstname_key, lastname_key).first(rowlimit.to_i)
    @new_household = Household.new
    respond_to do |format|
      format.html {
        if params[:ajax]
          render :partial => 'search_results'
        else
          render action: 'index'
        end
      }
      format.json { render action: 'index.json' }
    end
  end

  private

  def set_household
    @household = Household.find(params[:id])
    @all_states = State.all
  end

  def set_merge_household
    @merge_household = Household.find(params[:merge_id])
  end

  def household_params
    params.require(:household).permit(:address, :household_limit => [])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def address_params
    params.require(:address).permit(:line1, :line2, :city, :state, :zip, :state_id)
  end

  def household_limit_params
    params.require(:household).permit(household_limits_attributes:[:inventory_item_id, :quantity, :id, :_destroy])
  end

  def authorize_household
    @household ? (authorize @household) : (authorize :household)
  end
end

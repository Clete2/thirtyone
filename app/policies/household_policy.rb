class HouseholdPolicy < ApplicationPolicy
  attr_reader :user, :household

  def initialize(user, household)
    @user = user
    @household = household
  end

  def index?
    @user.has_access? PERM_RO_PERSON
  end

  def show?
    @user.has_access? PERM_RO_PERSON
  end

  def edit?
    @user.has_access? PERM_RW_PERSON
  end

  def new?
    @user.has_access? PERM_RW_PERSON
  end

  def destroy?
    @user.has_access? PERM_RW_PERSON
  end

  def search?
    @user.has_access? PERM_RO_PERSON
  end

  def select?
    @user.has_access? PERM_RW_PERSON
  end

  def create?
    new?
  end

  def merge_select?
    edit?
  end

  def merge_select_fields?
    merge_select?
  end

  def merge?
    merge_select?
  end

  def update?
    edit?
  end
end
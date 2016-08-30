class PersonPolicy < ApplicationPolicy
  attr_reader :user, :person

  def initialize(user, person)
    @user = user
    @person = person
  end

  def index?
    @user.has_access?(PERM_RO_PERSON)
  end

  def show?
    @user.has_access?(PERM_RO_PERSON)
  end

  def create?
    @user.has_access?(PERM_RW_PERSON)
  end

  def new?
    create?
  end

  def update?
    @user.has_access?(PERM_RW_PERSON)
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  def search?
    index?
  end

  # def scope
  #   Pundit.policy_scope!(user, Person)
  # end
end


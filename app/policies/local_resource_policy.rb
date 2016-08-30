class LocalResourcePolicy < ApplicationPolicy
  def index?
    @user.has_access?(PERM_RO_USER)
  end

  def show?
    @user.has_access?(PERM_RO_USER)
  end

  def new?
    @user.has_access?(PERM_RW_USER)
  end

  def edit?
    @user.has_access?(PERM_RW_USER)
  end

  def create?
    @user.has_access?(PERM_RW_USER)
  end

  def update?
    @user.has_access?(PERM_RW_USER)
  end

  def destroy?
    @user.has_access?(PERM_RW_USER)
  end

  def search?
    show?
  end
end
class UserPolicy < ApplicationPolicy
  def initialize(logged_in_user, actionable_user)
    @logged_in_user = logged_in_user
    @actionable_user = actionable_user
  end

  def index?
    @logged_in_user.has_access?(PERM_RO_USER)
  end

  def update?
    # Can update your own user or can update users with the PERM_RW_USER permission
    @logged_in_user == @actionable_user || @logged_in_user.has_access?(PERM_RW_USER)
  end

  def edit?
    update?
  end

  def cancel_pending_email_change?
    update?
  end

  def send_confirmation_email?
    update?
  end

  # Emulate what is in PersonPolicy#show?
  def show_person?
    @logged_in_user.has_access?(PERM_RO_PERSON)
  end

  # Email confirmations should not require a login, so we will always authorize.
  # The token in the URL is the real authorization mechanism.
  def confirm_email_change?
    true
  end
end
# == Schema Information
#
# Table name: users
#
#  id                        :integer          not null, primary key
#  created_at                :datetime
#  updated_at                :datetime
#  email                     :string           default(""), not null
#  encrypted_password        :string           default(""), not null
#  reset_password_token      :string
#  reset_password_sent_at    :datetime
#  remember_created_at       :datetime
#  sign_in_count             :integer          default(0), not null
#  current_sign_in_at        :datetime
#  last_sign_in_at           :datetime
#  current_sign_in_ip        :string
#  last_sign_in_ip           :string
#  person_id                 :integer
#  reset_email_token         :string
#  reset_email_token_sent_at :datetime
#  pending_email             :string
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :trackable, :validatable
  validate :validate_pending_email

  has_many :user_roles
  has_many :roles, :through => :user_roles
  belongs_to :person, autosave: true

  accepts_nested_attributes_for :user_roles, allow_destroy: true

  @send_confirmation = false

  def send_new_account_instructions
     token = set_reset_password_token
     send_new_account_instructions_notification(token)
     token
  end

  def send_new_account_instructions_notification(token)
     send_devise_notification(:new_account_instructions, token, {})
  end

  def permissions
    permissions = 0
    roles.each do |r|
      permissions |= r.permissions
    end
    return permissions
  end

  def has_access?(permission)
    permissions & PERM_ADMIN > 0 || permissions & permission > 0
  end

  def email=(new_email)
    if email != new_email and not email.blank?
      self[:reset_email_token] = Devise.friendly_token
      self[:reset_email_token_sent_at] = DateTime.now
      self[:pending_email] = new_email
      @send_confirmation = true
    else
      self[:email] = new_email
    end
  end

  def confirm_email_change
    if has_pending_email_change?
      cancel_pending_email_change(true)
    end
  end

  def cancel_pending_email_change(change_email = false)
    values = {reset_email_token: nil, reset_email_token_sent_at: nil, pending_email: nil}
    values[:email] = pending_email if change_email
    update(values)
  end

  def should_send_confirmation_email?
    @send_confirmation
  end

  def send_confirmation_email
    send_devise_notification(:confirmation_instructions, reset_email_token, {})
  end

  def has_pending_email_change?
    return ( not pending_email.nil? and not reset_email_token_sent_at.nil? and ( reset_email_token_sent_at > ( DateTime.now - Devise.confirm_within ) ) )
  end

  def pending_email_valid?
    if has_pending_email_change? and User.find_by_email(pending_email) != nil
      return false
    end
    return true
  end

  def validate_pending_email
      if not pending_email_valid?
        errors.add(:email, "already exists")
    end
  end
end

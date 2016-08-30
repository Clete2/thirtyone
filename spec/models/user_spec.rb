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

require 'rails_helper'

describe User do

  it 'should have a valid factory' do
    expect(build(:user)).to be_valid
  end

  context 'admin user' do
    it 'should have admin permissions' do
      expect(create(:user, :with_admin_role).has_access?(PERM_ADMIN)).to be_truthy
    end
  end
end


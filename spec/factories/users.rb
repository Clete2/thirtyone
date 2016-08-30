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

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    trait :with_person_ro_role do
      after(:create) do |user|
        user.roles << create(:person_ro_role)
      end
    end

    trait :with_person_rw_role do
      after(:create) do |user|
        user.roles << create(:person_ro_role)
        user.roles << create(:person_rw_role)
      end
    end

    trait :with_admin_role do
      after(:create) do |user|
        user.roles << create(:admin_role)
      end
    end
  end
end

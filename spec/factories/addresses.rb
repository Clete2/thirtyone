# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  line1      :string
#  line2      :string
#  city       :string
#  zip        :string
#  state_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :address do
    line1 { Faker::Address.street_address }
    city  { Faker::Address.city }
    state
    zip   { Faker::Address.zip }
  end
end

# == Schema Information
#
# Table name: people
#
#  id           :integer          not null, primary key
#  firstname    :string
#  lastname     :string
#  phone        :string
#  created_at   :datetime
#  updated_at   :datetime
#  household_id :integer
#  email        :string
#

FactoryGirl.define do
  factory :person do
    firstname { Faker::Name.first_name }
    lastname  { Faker::Name.last_name }
    phone     { Faker::Base.numerify('##########') }
    household

    factory :person_without_household do
      household nil
    end

    factory :invalid_person do
      firstname nil
    end
  end
end

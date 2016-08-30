# == Schema Information
#
# Table name: note_types
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :note_type do
    name { Faker::Lorem.word }
  end
end

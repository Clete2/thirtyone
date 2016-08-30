# == Schema Information
#
# Table name: states
#
#  id           :integer          not null, primary key
#  name         :string
#  abbreviation :string
#  created_at   :datetime
#  updated_at   :datetime
#

FactoryGirl.define do
  factory :state do
    name          'Illinois'
    abbreviation  'IL'
  end
end

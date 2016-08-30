# == Schema Information
#
# Table name: households
#
#  id         :integer          not null, primary key
#  name       :string
#  person_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  address_id :integer
#

require 'rails_helper'

describe Household do

  it 'has a valid factory' do
    expect(build(:household)).to be_valid
  end

  it 'has a valid factory with household members' do
    expect(build(:household_with_people)).to be_valid
  end

  it 'has the expected number of people in it' do
    household = build(:household_with_people, people_count: 4)
    expect(household.members.size).to eq(4)
  end

  it 'should be able to have notes' do
    household = build(:household)
    note   = build(:note)
    household.notes.push(note)
    expect(household.notes).to include(note)
  end
end

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

require 'rails_helper'

describe Person do

  it 'has a valid factory' do
    expect(build(:person)).to be_valid
  end

  it 'is invalid without a firstname' do
    expect(build(:person, firstname: nil)).not_to be_valid
  end

  it 'is invalid without a lastname' do
    expect(build(:person, lastname: nil)).not_to be_valid
  end

  it 'returns fullname as the first and last names combined' do
    person = build(:person)
    expect(person.fullname).to eq(person.firstname + ' ' + person.lastname)
  end

  it 'returns formal_name as lastname comma firstname' do
    person = build(:person)
    expect(person.formal_name).to eq(person.lastname + ', ' + person.firstname)
  end

  it 'should be able to have notes' do
    person = build(:person)
    note   = build(:note)
    person.notes.push(note)
    expect(person.notes).to include(note)
  end
end

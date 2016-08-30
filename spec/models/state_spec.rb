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

require 'rails_helper'

describe State do

  it 'has a valid factory' do
    expect(build(:state)).to be_valid
  end

  it 'aliases the abbreviation attribute to abbv' do
    state = build(:state)
    expect(state.abbv).to eq state.abbreviation
  end

end

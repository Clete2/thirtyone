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

require 'rails_helper'

describe Address do

  before(:each) { @address = build(:address) }

  it 'has a valid factory' do
    expect(FactoryGirl.build(:address)).to be_valid
  end

  it 'returns city, state, zip as a single string' do
    expect(@address.city_state_zip).to eq @address.city + ', ' + @address.state.abbreviation + ' ' + @address.zip
  end

  it 'returns a one line summary as a single string' do
    expect(@address.oneline_summary).to eq @address.line1 + ', ' + @address.city + ', ' + @address.state.abbreviation + ' ' + @address.zip
  end
end

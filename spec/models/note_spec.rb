# == Schema Information
#
# Table name: notes
#
#  id           :integer          not null, primary key
#  note         :string
#  note_type_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

require 'rails_helper'

describe Note do

  it 'has a valid factory' do
    expect(build(:note)).to be_valid
  end

end

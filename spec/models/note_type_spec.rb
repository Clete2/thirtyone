# == Schema Information
#
# Table name: note_types
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

describe NoteType do

  it 'has a valid factory' do
    expect(build(:note_type)).to be_valid
  end
end

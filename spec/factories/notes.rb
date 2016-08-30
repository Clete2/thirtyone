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

FactoryGirl.define do
  factory :note do
    note { Faker::Lorem.paragraph(4) }
    note_type
  end
end

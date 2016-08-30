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

class Note < ActiveRecord::Base
  belongs_to :note_type
#  has_and_belongs_to_many :person
#  has_and_belongs_to_many :visit
  validates_presence_of :note
end

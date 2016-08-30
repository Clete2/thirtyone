# == Schema Information
#
# Table name: note_types
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime
#  updated_at :datetime
#

class NoteType < ActiveRecord::Base
end

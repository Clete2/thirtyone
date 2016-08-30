# == Schema Information
#
# Table name: work_schedules
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  start_at   :datetime
#  end_at     :datetime
#  note       :string
#  created_at :datetime
#  updated_at :datetime
#

class WorkSchedule < ActiveRecord::Base
  belongs_to :user, foreign_key: 'user_id', class_name: 'User'
  has_and_belongs_to_many :notes
end

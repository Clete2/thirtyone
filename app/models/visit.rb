# == Schema Information
#
# Table name: visits
#
#  id         :integer          not null, primary key
#  person_id  :integer
#  visit_date :date
#  host_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  start_at   :datetime
#  end_at     :datetime
#

class Visit < ActiveRecord::Base
  has_and_belongs_to_many :notes
  belongs_to :person
  belongs_to :host, class_name: 'Person'

  scope :active, -> { where(end_at: nil)}
  scope :today, -> { where(visit_date: Date.today) }

  before_create do
    self.start_at = DateTime.now
  end
end

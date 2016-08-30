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

class Address < ActiveRecord::Base
  belongs_to :state

  validates_presence_of :line1, :city, :zip
  validates_format_of :zip, :with => /\d{5}/

  def city_state_zip
    "#{self.city}, #{self.state.abbv} #{self.zip}"
  end

  def line2
    if not self[:line2].nil?
      return self[:line2]
    else
      return ''
    end
  end

  def oneline_summary
    summary = ""
    summary << "#{self.line1}" if self.line1
    unless self.line2.blank?
      if summary
       summary << ', '
      else
         summary << ' '
      end
      summary << self.line2
    end
    summary << ", #{self.city_state_zip}"
  end

  def self.most_used_state
    state_id = Address.group(:state_id).order('count_state_id DESC').limit(1).count(:state_id).keys.first || 1
    State.find_by(id: state_id)
  end
end

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

class State < ActiveRecord::Base
  alias_attribute :abbv, :abbreviation

  def self.most_used_state
    Address.most_used_state
  end
end

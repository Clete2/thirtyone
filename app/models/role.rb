# == Schema Information
#
# Table name: roles
#
#  id          :integer          not null, primary key
#  created_at  :datetime
#  updated_at  :datetime
#  name        :string
#  permissions :integer          default(0)
#

class Role < ActiveRecord::Base

  has_many :user_roles
  has_many :users, :through => :user_roles
  validates :name, presence: true

  def self.default_role
    Role.find_by({name: 'User'})
  end
end

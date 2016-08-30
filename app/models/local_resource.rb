# == Schema Information
#
# Table name: local_resources
#
#  id            :integer          not null, primary key
#  business_name :string
#  phone         :string
#  phone_ext     :string
#  email         :string
#  url           :string
#  address_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class LocalResource < ActiveRecord::Base
  include PhoneMethod

  has_and_belongs_to_many :local_resource_categories
  validates_presence_of :local_resource_categories
  validates_presence_of :business_name
  validates_associated :address
  belongs_to :address
  before_save :strip_phone_number

  accepts_nested_attributes_for :address

  def strip_phone_number
    self.phone = self.strip_phone(self.phone)
    self.phone_ext = self.strip_phone_ext(self.phone_ext)
  end

end

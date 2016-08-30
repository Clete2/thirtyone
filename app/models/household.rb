# == Schema Information
#
# Table name: households
#
#  id         :integer          not null, primary key
#  name       :string
#  person_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  address_id :integer
#

class Household < ActiveRecord::Base
  belongs_to :person, dependent: :destroy
  belongs_to :address
  has_and_belongs_to_many :notes, join_table: 'notes_households'
  alias_method :head, :person
  alias_method :head=, :person=
  has_many :members, class_name: 'Person', foreign_key: 'household_id'
  has_many :household_limits
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :household_limits, allow_destroy: true
  validates_associated :address

  acts_as_paranoid

  def summary
    s = "#{person.formal_name}"
    s << " - #{self.address.oneline_summary}" if self.address
  end

  def name
    person.lastname
  end

  #alias_method :people, :persons
  #alias_method :members, :persons

end

class HouseholdLimit < ActiveRecord::Base
  belongs_to :inventory_item
  belongs_to :household
end

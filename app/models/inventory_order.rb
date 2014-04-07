# == Schema Information
#
# Table name: inventory_orders
#
#  id         :integer          not null, primary key
#  peopleid   :integer
#  enteredby  :integer
#  date       :date
#  created_at :datetime
#  updated_at :datetime
#

class InventoryOrder < ActiveRecord::Base
end

# == Schema Information
#
# Table name: inventory_order_items
#
#  id         :integer          not null, primary key
#  orderid    :integer
#  itemid     :integer
#  quantity   :integer
#  created_at :datetime
#  updated_at :datetime
#

class InventoryOrderItem < ActiveRecord::Base
end

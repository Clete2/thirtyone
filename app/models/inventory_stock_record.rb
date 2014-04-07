# == Schema Information
#
# Table name: inventory_stock_records
#
#  id         :integer          not null, primary key
#  itemid     :integer
#  quantity   :integer
#  received   :date
#  created_at :datetime
#  updated_at :datetime
#

class InventoryStockRecord < ActiveRecord::Base
end

# == Schema Information
#
# Table name: inventory_items
#
#  id         :integer          not null, primary key
#  name       :string
#  quantity   :integer
#  barcode    :string
#  unit       :string
#  created_at :datetime
#  updated_at :datetime
#

class InventoryItem < ActiveRecord::Base
end

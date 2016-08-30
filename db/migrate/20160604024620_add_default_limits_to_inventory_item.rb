class AddDefaultLimitsToInventoryItem < ActiveRecord::Migration
  def change
    add_column :inventory_items, :default_limit, :integer
    add_column :inventory_items, :limit_reset_after_days, :integer
  end
end

class RenameInventoryOrderItems < ActiveRecord::Migration
  def change
    rename_table :inventory_order_items, :inventory_visit_items
  end
end

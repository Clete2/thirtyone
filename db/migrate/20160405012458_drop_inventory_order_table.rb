class DropInventoryOrderTable < ActiveRecord::Migration
  def up
    drop_table :inventory_orders
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

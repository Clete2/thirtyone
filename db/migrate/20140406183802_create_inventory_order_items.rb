class CreateInventoryOrderItems < ActiveRecord::Migration
  def change
    create_table :inventory_order_items do |t|
      t.integer :orderid
      t.integer :itemid
      t.integer :quantity

      t.timestamps
    end
  end
end

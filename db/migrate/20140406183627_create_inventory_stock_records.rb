class CreateInventoryStockRecords < ActiveRecord::Migration
  def change
    create_table :inventory_stock_records do |t|
      t.integer :itemid
      t.integer :quantity
      t.date :received

      t.timestamps
    end
  end
end

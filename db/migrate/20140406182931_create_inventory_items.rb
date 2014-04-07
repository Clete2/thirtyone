class CreateInventoryItems < ActiveRecord::Migration
  def change
    create_table :inventory_items do |t|
      t.string :name
      t.integer :quantity
      t.string :barcode
      t.string :unit

      t.timestamps
    end
  end
end

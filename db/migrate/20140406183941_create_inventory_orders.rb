class CreateInventoryOrders < ActiveRecord::Migration
  def change
    create_table :inventory_orders do |t|
      t.integer :peopleid
      t.integer :enteredby
      t.date :date

      t.timestamps
    end
  end
end

class CreateHouseholdLimits < ActiveRecord::Migration
  def change
    create_table :household_limits do |t|
      t.references :inventory_item, index: true, foreign_key: true
      t.references :household, index: true, foreign_key: true
      t.integer :quantity
      t.integer :reset_after_days

      t.timestamps null: false
    end
  end
end

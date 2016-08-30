class AddDeletedAtToHousehold < ActiveRecord::Migration
  def change
    add_column :households, :deleted_at, :datetime
    add_index :households, :deleted_at
  end
end

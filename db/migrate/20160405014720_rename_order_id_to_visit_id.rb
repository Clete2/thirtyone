class RenameOrderIdToVisitId < ActiveRecord::Migration
  def change
    rename_column :inventory_visit_items, :orderid, :visitid
  end
end

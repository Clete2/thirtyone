json.array!(@inventory_stock_records) do |inventory_stock_record|
  json.extract! inventory_stock_record, :id, :itemid, :quantity, :received
  json.url inventory_stock_record_url(inventory_stock_record, format: :json)
end

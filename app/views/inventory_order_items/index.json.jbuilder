json.array!(@inventory_order_items) do |inventory_order_item|
  json.extract! inventory_order_item, :id, :orderid, :itemid, :quantity
  json.url inventory_order_item_url(inventory_order_item, format: :json)
end

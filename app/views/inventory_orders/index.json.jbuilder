json.array!(@inventory_orders) do |inventory_order|
  json.extract! inventory_order, :id, :peopleid, :enteredby, :date
  json.url inventory_order_url(inventory_order, format: :json)
end

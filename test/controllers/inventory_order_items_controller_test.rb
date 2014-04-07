require 'test_helper'

class InventoryOrderItemsControllerTest < ActionController::TestCase
  setup do
    @inventory_order_item = inventory_order_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inventory_order_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inventory_order_item" do
    assert_difference('InventoryOrderItem.count') do
      post :create, inventory_order_item: { itemid: @inventory_order_item.itemid, orderid: @inventory_order_item.orderid, quantity: @inventory_order_item.quantity }
    end

    assert_redirected_to inventory_order_item_path(assigns(:inventory_order_item))
  end

  test "should show inventory_order_item" do
    get :show, id: @inventory_order_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inventory_order_item
    assert_response :success
  end

  test "should update inventory_order_item" do
    patch :update, id: @inventory_order_item, inventory_order_item: { itemid: @inventory_order_item.itemid, orderid: @inventory_order_item.orderid, quantity: @inventory_order_item.quantity }
    assert_redirected_to inventory_order_item_path(assigns(:inventory_order_item))
  end

  test "should destroy inventory_order_item" do
    assert_difference('InventoryOrderItem.count', -1) do
      delete :destroy, id: @inventory_order_item
    end

    assert_redirected_to inventory_order_items_path
  end
end

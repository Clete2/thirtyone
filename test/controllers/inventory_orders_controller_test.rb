require 'test_helper'

class InventoryOrdersControllerTest < ActionController::TestCase
  setup do
    @inventory_order = inventory_orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inventory_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inventory_order" do
    assert_difference('InventoryOrder.count') do
      post :create, inventory_order: { date: @inventory_order.date, enteredby: @inventory_order.enteredby, peopleid: @inventory_order.peopleid }
    end

    assert_redirected_to inventory_order_path(assigns(:inventory_order))
  end

  test "should show inventory_order" do
    get :show, id: @inventory_order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inventory_order
    assert_response :success
  end

  test "should update inventory_order" do
    patch :update, id: @inventory_order, inventory_order: { date: @inventory_order.date, enteredby: @inventory_order.enteredby, peopleid: @inventory_order.peopleid }
    assert_redirected_to inventory_order_path(assigns(:inventory_order))
  end

  test "should destroy inventory_order" do
    assert_difference('InventoryOrder.count', -1) do
      delete :destroy, id: @inventory_order
    end

    assert_redirected_to inventory_orders_path
  end
end

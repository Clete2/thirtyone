require 'test_helper'

class InventoryStockRecordsControllerTest < ActionController::TestCase
  setup do
    @inventory_stock_record = inventory_stock_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inventory_stock_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inventory_stock_record" do
    assert_difference('InventoryStockRecord.count') do
      post :create, inventory_stock_record: { itemid: @inventory_stock_record.itemid, quantity: @inventory_stock_record.quantity, received: @inventory_stock_record.received }
    end

    assert_redirected_to inventory_stock_record_path(assigns(:inventory_stock_record))
  end

  test "should show inventory_stock_record" do
    get :show, id: @inventory_stock_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inventory_stock_record
    assert_response :success
  end

  test "should update inventory_stock_record" do
    patch :update, id: @inventory_stock_record, inventory_stock_record: { itemid: @inventory_stock_record.itemid, quantity: @inventory_stock_record.quantity, received: @inventory_stock_record.received }
    assert_redirected_to inventory_stock_record_path(assigns(:inventory_stock_record))
  end

  test "should destroy inventory_stock_record" do
    assert_difference('InventoryStockRecord.count', -1) do
      delete :destroy, id: @inventory_stock_record
    end

    assert_redirected_to inventory_stock_records_path
  end
end

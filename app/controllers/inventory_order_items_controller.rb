class InventoryOrderItemsController < ApplicationController
  before_action :set_inventory_order_item, only: [:show, :edit, :update, :destroy]

  # GET /inventory_order_items
  # GET /inventory_order_items.json
  def index
    @inventory_order_items = InventoryOrderItem.all
  end

  # GET /inventory_order_items/1
  # GET /inventory_order_items/1.json
  def show
  end

  # GET /inventory_order_items/new
  def new
    @inventory_order_item = InventoryOrderItem.new
  end

  # GET /inventory_order_items/1/edit
  def edit
  end

  # POST /inventory_order_items
  # POST /inventory_order_items.json
  def create
    @inventory_order_item = InventoryOrderItem.new(inventory_order_item_params)

    respond_to do |format|
      if @inventory_order_item.save
        format.html { redirect_to @inventory_order_item, notice: 'Inventory order item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @inventory_order_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @inventory_order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inventory_order_items/1
  # PATCH/PUT /inventory_order_items/1.json
  def update
    respond_to do |format|
      if @inventory_order_item.update(inventory_order_item_params)
        format.html { redirect_to @inventory_order_item, notice: 'Inventory order item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @inventory_order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_order_items/1
  # DELETE /inventory_order_items/1.json
  def destroy
    @inventory_order_item.destroy
    respond_to do |format|
      format.html { redirect_to inventory_order_items_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inventory_order_item
      @inventory_order_item = InventoryOrderItem.find_by(id: params[:id])
      redirect_to inventory_order_items_url unless @inventory_order_item
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inventory_order_item_params
      params.require(:inventory_order_item).permit(:orderid, :itemid, :quantity)
    end
end

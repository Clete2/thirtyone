class InventoryOrdersController < ApplicationController
  before_action :set_inventory_order, only: [:show, :edit, :update, :destroy]

  # GET /inventory_orders
  # GET /inventory_orders.json
  def index
    @inventory_orders = InventoryOrder.all
  end

  # GET /inventory_orders/1
  # GET /inventory_orders/1.json
  def show
  end

  # GET /inventory_orders/new
  def new
    @inventory_order = InventoryOrder.new
  end

  # GET /inventory_orders/1/edit
  def edit
  end

  # POST /inventory_orders
  # POST /inventory_orders.json
  def create
    @inventory_order = InventoryOrder.new(inventory_order_params)

    respond_to do |format|
      if @inventory_order.save
        format.html { redirect_to @inventory_order, notice: 'Inventory order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @inventory_order }
      else
        format.html { render action: 'new' }
        format.json { render json: @inventory_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inventory_orders/1
  # PATCH/PUT /inventory_orders/1.json
  def update
    respond_to do |format|
      if @inventory_order.update(inventory_order_params)
        format.html { redirect_to @inventory_order, notice: 'Inventory order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @inventory_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_orders/1
  # DELETE /inventory_orders/1.json
  def destroy
    @inventory_order.destroy
    respond_to do |format|
      format.html { redirect_to inventory_orders_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inventory_order
      @inventory_order = InventoryOrder.find_by(id: params[:id])
      redirect_to inventory_orders_url unless @inventory_order
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inventory_order_params
      params.require(:inventory_order).permit(:peopleid, :enteredby, :date)
    end
end

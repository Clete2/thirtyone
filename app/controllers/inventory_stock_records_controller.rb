class InventoryStockRecordsController < ApplicationController
  before_action :set_inventory_stock_record, only: [:show, :edit, :update, :destroy]

  # GET /inventory_stock_records
  # GET /inventory_stock_records.json
  def index
    @inventory_stock_records = InventoryStockRecord.all
  end

  # GET /inventory_stock_records/1
  # GET /inventory_stock_records/1.json
  def show
  end

  # GET /inventory_stock_records/new
  def new
    @inventory_stock_record = InventoryStockRecord.new
  end

  # GET /inventory_stock_records/1/edit
  def edit
  end

  # POST /inventory_stock_records
  # POST /inventory_stock_records.json
  def create
    @inventory_stock_record = InventoryStockRecord.new(inventory_stock_record_params)

    respond_to do |format|
      if @inventory_stock_record.save
        format.html { redirect_to @inventory_stock_record, notice: 'Inventory stock record was successfully created.' }
        format.json { render action: 'show', status: :created, location: @inventory_stock_record }
      else
        format.html { render action: 'new' }
        format.json { render json: @inventory_stock_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inventory_stock_records/1
  # PATCH/PUT /inventory_stock_records/1.json
  def update
    respond_to do |format|
      if @inventory_stock_record.update(inventory_stock_record_params)
        format.html { redirect_to @inventory_stock_record, notice: 'Inventory stock record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @inventory_stock_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_stock_records/1
  # DELETE /inventory_stock_records/1.json
  def destroy
    @inventory_stock_record.destroy
    respond_to do |format|
      format.html { redirect_to inventory_stock_records_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inventory_stock_record
      @inventory_stock_record = InventoryStockRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inventory_stock_record_params
      params.require(:inventory_stock_record).permit(:itemid, :quantity, :received)
    end
end

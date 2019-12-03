class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy]
  before_action :find_ids

  # GET /requests
  # GET /requests.json
  def index
    @requests = Request.all
  end

  def table_requests
    @requests = Request.where(table_id: params[:table_id])
    render template: 'requests/index'
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
  end

  # GET /requests/new
  def new
    @request = Request.new
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests
  # POST /requests.json
  def create
    @request = Request.new(request_params)
    respond_to do |format|
      if @request.save
        format.html { redirect_to @request, notice: 'Request was successfully created.' }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_amounts
    @request = Request.find(params[:request_id])
    @request.amounts.new(amounts_params) unless @request.amounts.nil?
    if @request.save!      
      render json: @request, status: 200
    else
     render json: @request.errors, status: :unprocessable_entity
    end
  end

  def find_amounts
    amounts = Request.find(params[:request_id]).amounts.pluck(:id, :item_id, :amount)
    amounts.each do |amount|
      begin
        amount << Item.find(amount[1]).name
      rescue
        next
      end
    end
    render json: amounts
  end

  def delete_amount
    @request = Request.find(params[:request_id])
    amount = @request.amounts.find(params[:id])
    if amount.destroy!
      render json: @request, status: 200
    else
      render json: @request.errors, status: :unprocessable_entity
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
      params.require(:request).permit(:amount, :customer_id, :table_id, :waiter_id)
    end

    def amounts_params
      params.require(:amounts).permit(:id, :item_id, :amount)
    end

    def find_ids
      @customers = Customer.all.pluck(:name, :id)
      @tables = Table.all.pluck(:number, :id)
      @items = Item.all.pluck(:name, :id)
      @waiters = Waiter.all.pluck(:name, :id)
    end
end

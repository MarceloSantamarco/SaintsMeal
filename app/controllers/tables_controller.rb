class TablesController < ApplicationController
  before_action :set_table, only: [:show, :edit, :update, :destroy,:generate_bill]

  # GET /tables
  # GET /tables.json
  def index
    @tables = Table.all
  end

  def generate_bill
    requests = @table.requests

    msg = "Saint's Meal - #{Time.now}\n\n"
    requests.each do |request|
      bill = []
      msg += "Cliente: #{Customer.find(request.customer_id).name}, CPF: #{Customer.find(request.customer_id).CPF}\n\n\n"
      msg += "Garçom: #{Waiter.find(request.waiter_id).name}\n\n"
      msg += "Pedidos:\n"
      request.amounts.each do |amount|
        msg += "#{Item.find(amount.item_id).name}  ----> \t x#{amount.amount}\n"
        bill << Item.find(amount.item_id).price * amount.amount
      end
      bill = bill.sum().round(2)
      msg += "\n|----------------------------------|\n"
      msg += "          Total: #{bill}            \n"
      msg += "|----------------------------------|"

      msg += "\n\n\n--------------------- DESTAQUE AQUI ------------------------\n\n\n"

    end
    send_data msg, filename: "Conta.txt"
  end

  # GET /tables/1
  # GET /tables/1.json
  def show
  end

  # GET /tables/new
  def new
    @table = Table.new
  end

  # GET /tables/1/edit
  def edit
  end

  # POST /tables
  # POST /tables.json
  def create
    @table = Table.new(table_params)

    respond_to do |format|
      if @table.save
        format.html { redirect_to @table, notice: 'Table was successfully created.' }
        format.json { render :show, status: :created, location: @table }
      else
        format.html { render :new }
        format.json { render json: @table.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tables/1
  # PATCH/PUT /tables/1.json
  def update
    respond_to do |format|
      if @table.update(table_params)
        format.html { redirect_to @table, notice: 'Table was successfully updated.' }
        format.json { render :show, status: :ok, location: @table }
      else
        format.html { render :edit }
        format.json { render json: @table.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tables/1
  # DELETE /tables/1.json
  def destroy
    @table.destroy
    respond_to do |format|
      format.html { redirect_to tables_url, notice: 'Table was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_table
      @table = Table.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def table_params
      params.require(:table).permit(:number)
    end
end

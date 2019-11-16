class AddCustomerAndTableToRequest < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :customer_id, :integer
    add_column :requests, :table_id, :integer
  end
end

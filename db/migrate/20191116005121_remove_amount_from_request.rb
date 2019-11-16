class RemoveAmountFromRequest < ActiveRecord::Migration[6.0]
  def change
    remove_column :requests, :item_id, :integer
    remove_column :requests, :amount, :integer
  end
end

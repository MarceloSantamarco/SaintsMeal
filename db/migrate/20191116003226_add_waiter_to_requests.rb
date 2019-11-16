class AddWaiterToRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :waiter_id, :integer
  end
end

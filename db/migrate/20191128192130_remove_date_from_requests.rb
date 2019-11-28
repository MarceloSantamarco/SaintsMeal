class RemoveDateFromRequests < ActiveRecord::Migration[6.0]
  def change
    remove_column :requests, :date, :datetime
  end
end

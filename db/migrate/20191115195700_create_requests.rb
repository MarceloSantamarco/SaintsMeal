class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.integer :amount
      t.date :date

      t.timestamps
    end
  end
end

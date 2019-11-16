class CreateAmounts < ActiveRecord::Migration[6.0]
  def change
    create_table :amounts do |t|
      t.integer :item_id
      t.integer :request_id
      t.integer :amount

      t.timestamps
    end
  end
end

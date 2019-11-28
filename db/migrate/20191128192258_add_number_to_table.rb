class AddNumberToTable < ActiveRecord::Migration[6.0]
  def change
    add_column :tables, :number, :integer
  end
end

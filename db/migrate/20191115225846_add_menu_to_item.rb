class AddMenuToItem < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :menu_id, :integer
  end
end

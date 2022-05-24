class AddColumnsToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :item_name, :string
    add_column :orders, :item_price, :integer
    add_column :orders, :item_exp, :integer
  end
end

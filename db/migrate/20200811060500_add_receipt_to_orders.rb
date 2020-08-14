class AddReceiptToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :receipt, :boolean, default: false
  end
end

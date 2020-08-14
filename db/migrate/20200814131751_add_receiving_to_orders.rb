class AddReceivingToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :receiving, :boolean
  end
end

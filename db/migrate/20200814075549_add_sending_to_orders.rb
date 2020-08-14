class AddSendingToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :sending, :boolean
  end
end

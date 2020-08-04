class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :size
      t.string :hw
      t.string :paper
      t.integer :number
      t.date :delivery_date
      t.string :note
      t.string :order_status
      t.references :design, foreign_key: true

      t.timestamps
    end
  end
end

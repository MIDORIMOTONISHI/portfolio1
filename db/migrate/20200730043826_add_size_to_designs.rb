class AddSizeToDesigns < ActiveRecord::Migration[5.1]
  def change
    add_column :designs, :size, :string
    add_column :designs, :number, :integer
    add_column :designs, :hw, :string
    add_column :designs, :note, :string
  end
end

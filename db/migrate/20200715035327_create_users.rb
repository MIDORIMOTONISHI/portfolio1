class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :affiliation
      t.string :password_digest
      t.boolean :designer, default: false
      t.boolean :admin, default: false

      t.timestamps
    end
  end
end

class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.string :city
      t.string :gender
      t.integer :phone_num
      t.integer :role
      t.timestamps
    end
  end
end

class CreateShoes < ActiveRecord::Migration[5.0]
  def change
    create_table :shoes do |t|
      t.string :brand
      t.integer :shoe_size
      t.float :price
      t.text :description
      t.belongs_to :user
      t.timestamps
    end
  end
end

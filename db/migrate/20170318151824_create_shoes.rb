class CreateShoes < ActiveRecord::Migration[5.0]
  def change
    create_table :shoes do |t|
      t.string :name
      t.string :brand
      t.integer :shoe_size
      t.float :price
      t.json :photos
      t.text :description
      t.belongs_to :user

      t.timestamps
    end
  end
end

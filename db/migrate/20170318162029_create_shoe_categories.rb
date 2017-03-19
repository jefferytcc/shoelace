class CreateShoeCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :shoe_categories do |t|
    	t.belongs_to :shoe
    	t.belongs_to :category
      t.timestamps
    end
  end
end

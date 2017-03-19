class Category < ApplicationRecord
		has_many :shoe_categories
	  has_many :shoes, through: :shoe_categories
end

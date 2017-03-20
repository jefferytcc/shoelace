class Shoe < ApplicationRecord
	belongs_to :user
	has_many :shoe_categories
	has_many :categories, through: :shoe_categories

	attr_accessor :photos
  mount_uploaders :photos, ImageUploader

end

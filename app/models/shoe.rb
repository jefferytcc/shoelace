class Shoe < ApplicationRecord
	
	belongs_to :user
	
	has_many :shoe_categories
	has_many :categories, through: :shoe_categories

	has_many :purchases
	has_many :buyers, through: :purchases

	attr_accessor :photos
  mount_uploaders :photos, ImageUploader

  include PgSearch

 	pg_search_scope :search_full_text,
 		:using => {
 		:tsearch => {:any_word => true }
 	},

		:against => {
			:brand => 'A',
			:name => 'B'
		}

	def cart_action(current_user_id)
  	if $redis.sismember "cart#{current_user_id}", id
    	"Remove from"
  	else
    	"Add to"
  	end
	end
	
end

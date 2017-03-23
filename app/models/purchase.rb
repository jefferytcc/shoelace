class Purchase < ApplicationRecord

belongs_to :shoe
belongs_to :buyer, class_name: 'User'

end

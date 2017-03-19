json.extract! shoe, :id, :brand, :shoe_size, :price, :description, :created_at, :updated_at
json.url shoe_url(shoe, format: :json)

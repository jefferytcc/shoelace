# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Seed Users
user = {}
user['password'] = '123456'
user['password_confirmation'] = '123456'

ActiveRecord::Base.transaction do
  20.times do 
    user['username'] = Faker::Name.first_name 
    user['first_name'] = Faker::Name.first_name 
    user['last_name'] = Faker::Name.last_name
    user['email'] = Faker::Internet.email
    user['gender'] = rand(1..2)
    user['phone_num'] = Faker::PhoneNumber.phone_number
    user['city'] = Faker::Address.city
    

    User.create(user)
  end
end 

# Seed Listings
shoe = {}
uids = []
User.all.each { |u| uids << u.id }

ActiveRecord::Base.transaction do
  40.times do 
    shoe['name'] = Faker::App.name

    shoe['brand'] = ["Nike", "Adidas", "Puma", "Under Armour", "Reebok", "Converse", "Vans", "Onitsuka Tiger", "New Balance"].sample

    shoe['shoe_size'] = rand(7..14)

    shoe['price'] = rand(80..500)
    shoe['description'] = Faker::Hipster.sentence

    shoe['user_id'] = uids.sample

    Shoe.create(shoe)
  end
end
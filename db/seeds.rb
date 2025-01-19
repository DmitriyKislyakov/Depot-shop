# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Product.delete_all

Product.create!(title: 'programming Ruby',
description: %(<p>Ruby is a top</p>),
image_url: 'ruby.jpg',
price: 49.95)

Product.create!(title: 'JavaScript',
description: %(<p> js from front</p>),
image_url: 'js.jpg',
price: 25.19)

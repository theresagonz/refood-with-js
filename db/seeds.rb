# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = [
  {name: 'Joe', username: 'joe', email: 'joe@joe.com', password: '123', password_confirmation: '123', zip_code: 12345}, {name: 'Sue', username: 'sue', email: 'sue@sue.com', password: '123', password_confirmation: '123', zip_code: 80223}
]

users.each do |user|
  new_user = User.new(user)
  new_user.build_giver
  new_user.build_receiver
  new_user.save
end

new_offer = User.first.giver.offers.build(title: "Box of apples from my orchard", description: "Around 20 fuji apples in a box", availability: "Arrange for pickup anytime this weekend", expiration: "12/25/2018 1:30 PM")
new_offer.save

new_request = User.last.receiver.requests.build(message: "I can pick up around 4:30!")
new_request.save
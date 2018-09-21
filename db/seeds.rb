# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = [
  {
    name: 'Joe',
    email: 'joe@joe.com',
    address: '95 Bannock St',
    city: 'Denver', state: 'CO',
    zip_code: 80223,
    phone: '1234567890',
    password: '123',
    password_confirmation: '123'
  },
  {
    name: 'Sue',
    email: 'sue@sue.com',
    address: '241 W 113th St',
    city: 'New York',
    state: 'NY',
    zip_code: 10026,
    phone: '1234567899',
    password: '123',
    password_confirmation: '123'
  },
  {
    name: 'James Franco',
    email: 'j@j.com',
    address: '3267 W Wrightwood Ave',
    city: 'Chicago',
    state: 'IL',
    zip_code: 60647,
    phone: '9876543210',
    password: '123',
    password_confirmation: '123'
  }
]

offers = [
  {
    giver_id: 1,
    headline: "Box of apples",
    description: "Around 20 fuji apples from a happy little tree",
    location: "",
    availability: "Anytime this weekend",
    expiration: "9/25/2018 1:30 PM"
  },
  {
    giver_id: 3,
    headline: "Pan of veg lasagna from catered lunch",
    description: "One large pan of spinach lasagna, hot n ready",
    location: "1 Wall St",
    expiration: "9/20/2018 6:30 PM"
  },
  {
    giver_id: 2,
    headline: "Five boxes mac n cheese, blue box",
    description: "Gluten free now, cheesy mac needs new home",
    location: "241 W 113th St, New York, NY 10026",
    availability: "evenings after 7",
    expiration: "2/28/19 11:59 PM"
  }
]

requests = [
  {
    offer_id: 2,
    requestor_id: 2,
    message: "I can pick up around 4:30! Please text your address",
    requestor_phone: "9175555555",
    requestor_email: "sue@sue.com"
  },
  {
    offer_id: 1,
    requestor_id: 3,
    message: "Would it be possible to grab just half of these? I could stop by tomorrow early afternoon. I have a bag.",
    requestor_email: "j@j.com"
  },
  {
    offer_id: 2,
    requestor_id: 1,
    message: "I can pickup ASAP",
    requestor_email: "joe@joe.com"
  }
]
    
users.each do |user|
  new_user = User.new(user)
  new_user.build_giver
  new_user.build_requestor
  new_user.build_receiver
  new_user.save
end

offers.each do |offer|
  Offer.create(offer)
end

requests.each do |request|
  Request.create(request)
end

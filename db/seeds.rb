6.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email
  User.create(
    name: name,
    email: email
  )
  Store.create(
    name: "#{name}\'s store",
    email: email
  )
end

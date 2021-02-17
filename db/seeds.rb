6.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email
  User.create(
    name: name,
    email: email,
    password: 'password',
    password_confirmation: 'password'
  )
  Store.create(
    name: "#{name}\'s store",
    email: email,
    password: 'password',
    password_confirmation: 'password',
  )

  Store.all.each do |store|
    4.times do |t|
      store.promotions.create(
        content: "#{store.name}\'s promotion\n
         #{SecureRandom.hex(40)}"
      )
    end
  end
end

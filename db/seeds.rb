6.times do |n|
  name = Faker::TvShows::Simpsons.character
  email = Faker::Internet.email
  User.create(
    name: name,
    email: email,
    password: 'password',
    password_confirmation: 'password'
  )
  introduction = "#{Faker::Food.dish}, #{Faker::Food.dish}がオススメ！\n是非、お越しください。"
  locate = Jipcode.locate("#{rand(3..9)}000000")[0]
  Store.create(
    name: "#{name}\'s store",
    email: email,
    password: 'password',
    password_confirmation: 'password',
    introduction: introduction,
    prefecture: locate[:prefecture],
    city: locate[:city],
    street_address: locate[:town]
  )
end
Store.all.each do |store|
  n = Store.count
  3.times do
    begin
      StoreFavorite.create(
        follower: store,
        followed: Store.all[rand(0...n)],
      )
    rescue => e
      puts "#{e.class}"
      puts "-"*20
      puts "#{e.message}"
    end
    store.promotions.create(
      title: "#{store.name}からのお知らせ",
      content: "#{Faker::Food.dish}がお買い得です。\nこの機会に是非、お買い求めください。"
    )
  end
end
User.all.each do |user|
  n = Store.count
  3.times do
    begin
      UserFavorite.create(
        user: user,
        store: Store.all[rand(0...n)],
      )
    rescue => e
      puts "#{e.class}"
      puts "-"*20
      puts "#{e.message}"
    end
    user.comments.create(
      content: "#{Faker::Food.dish}が美味しかった、また来ます",
      store: Store.all[rand(0...n)]
    )
  end
end

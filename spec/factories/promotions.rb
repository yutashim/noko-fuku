FactoryBot.define do
  factory :promotion do
    title {'タイトル'}
    content {'お店からのお知らせ'}
    store {Store.first}
  end
end

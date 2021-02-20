FactoryBot.define do
  factory :store do
    name {'store_a'}
    email {'store_a@mail.com'}
    password {'password'}
    password_confirmation {'password'}
  end
  factory :store_b, class: Store do
    name {'store_b'}
    email {'store_b@mail.com'}
    password {'password'}
    password_confirmation {'password'}
  end
end

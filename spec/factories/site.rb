FactoryBot.define do
  factory :site do
    prefecture { Faker::Number.between(from: 1, to: 47)}
    municipality { Faker::Address.city}
    address { Faker::Address.zip_code}
    association :user
  end
end
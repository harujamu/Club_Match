FactoryBot.define do
  factory :admin do
    email { Faker::Internet.email}
    password { Faker::Lorem.charecters(number:6)}
  end
end
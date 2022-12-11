FactoryBot.define do
  factory :genre do
   name { Faker::Lorem.characters(number: 3)}
  end
end
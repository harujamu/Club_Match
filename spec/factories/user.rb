FactoryBot.define do
 
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    club_name { Faker::Internet.user_name }
    captain_first_name { Faker::Name.first_name }
    captain_last_name { Faker::Name.last_name }
    prefecture { Faker::Number.between(from: 1, to: 47) }
    municipality { Faker::Lorem.characters(number:3) }
    address { Faker::Lorem.characters(number:3) }
    age_group { Faker::Number.between(from: 1, to: 5) }
    association :genre
  end
  

end
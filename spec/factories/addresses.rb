FactoryBot.define do
  factory :address do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    line1 { Faker::Address.street_address }
    zip { Faker::Address.zip }
    city { Faker::Address.city }
    state { Faker::Address.state }
    country { Faker::Address.country_code }
  end
end

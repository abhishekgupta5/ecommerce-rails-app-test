FactoryBot.define do
  factory :shipping_method do
    name { Faker::Name.name }
    delivery_time_in_days { Faker::Number.within(range: 1..10) }
    country { Faker::Address.country_code }
  end
end

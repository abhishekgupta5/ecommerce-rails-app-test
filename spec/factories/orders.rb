FactoryBot.define do
  factory :order do
    association :shipping_address, factory: :address
    credit_card
    email { Faker::Internet.email }
  end
end

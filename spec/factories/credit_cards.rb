FactoryBot.define do
  factory :credit_card do
    number { "4242424242424242" }
    name { Faker::Name.name }
    exp_month { "03" }
    exp_year { (Time.zone.today.year + 4).to_s }
    cvc { "123" }
  end
end

FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    price { Faker::Commerce.price }
    image { Rack::Test::UploadedFile.new(Rails.root.glob("db/seeds/products/*.jpg").sample, "image/jpeg") }
  end
end

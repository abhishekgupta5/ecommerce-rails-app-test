FactoryBot.define do
  factory :line_item do
    order
    product
    quantity { Random.rand(1..3) }
  end
end

FactoryBot.define do
  factory :erp_datum do
    order
    entity_id { "or_#{SecureRandom.hex(8)}" }
  end
end

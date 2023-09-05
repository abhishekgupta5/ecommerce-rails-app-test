class ErpDatum < ApplicationRecord
  # We assume that there is 1-1 relation of an erp_data row and order
  belongs_to :order

  validates :entity_id, presence: true
  validates :order_id, presence: true

  class << self
    def update_erp_data(order)
      entity_id = fetch(order)
      save_in_db(entity_id, order)
    end

    private

    def fetch(order)
      ErpClient.new(order).erp_for_order["id"]
    end

    def save_in_db(entity_id, order)
      ErpDatum.create!(entity_id: entity_id, order: order)
    end
  end
end

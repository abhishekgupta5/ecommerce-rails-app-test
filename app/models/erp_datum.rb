class ErpDatum < ApplicationRecord
  # We assume that there is 1-1 relation of an erp_data row and order
  belongs_to :order
end

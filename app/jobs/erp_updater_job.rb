class ErpUpdaterJob < ApplicationJob
  queue_as :default

  def perform(order)
    ErpDatum.update_erp_data(order)
  end
end

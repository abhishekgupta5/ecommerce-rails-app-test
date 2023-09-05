require "rails_helper"

RSpec.describe ErpUpdaterJob, type: :job do
  describe "#perform_later" do
    let(:shipping_method) { create(:shipping_method) }
    let(:address) { create(:address, country: shipping_method.country) }
    let(:order) { create(:order, shipping_address: address) }
    before(:each) do
      ActiveJob::Base.queue_adapter = :test
    end

    it "updates ERP data" do
      expect {
        ErpUpdaterJob.perform_later(order)
      }.to have_enqueued_job.with(order)
    end

    it "job scheduled with no wait time on default queue" do
      expect {
        ErpUpdaterJob.perform_later(order)
      }.to have_enqueued_job.with(order).on_queue(:default).at(:no_wait).exactly(:once)
    end
  end
end

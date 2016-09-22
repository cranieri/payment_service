require 'rails_helper'

describe PaymentGetter do
  describe "#get" do
    it "returns the requested payment" do
      payments = { body: {"payments" => [{ "id" => "123"}]}, status: 200 }
      payment_api = double(:payment_api, get_payments: payments)

      expected_response = { body: { "id" => "123"}, status: 200 }
      payment_getter = PaymentGetter.new(payment_api)

      expect(payment_getter.get("123", "bearer")).to eq expected_response
    end
  end
end

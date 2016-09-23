require 'rails_helper'

describe PaymentGetter do
  describe "#get" do
    let(:payments) do
      { body: {"payments" => [{ "id" => "123"}]}, status: "200" }
    end

    context "when response status is 200" do
      it "returns the requested payment" do
        payment_api = double(:payment_api, get_payments: payments)

        expected_response = { body: { "id" => "123"}, status: "200" }
        payment_getter = PaymentGetter.new(payment_api, "123")

        expect(payment_getter.get("bearer")).to eq expected_response
      end
    end

    context "when the request is not authorized" do
      it "returns 401" do
        payments = { body: {"message" => "some message"}, status: "401" }
        payment_api = double(:payment_api, get_payments: payments)

        expected_response = { body: {"message"=>"some message"}, status: "401" }
        payment_getter = PaymentGetter.new(payment_api, "123")

        expect(payment_getter.get("bearer")).to eq expected_response
      end
    end

    context "when no payments are found" do
      it "returns 404" do
        payments = { body: {"payments" => [{"id" => "456"}]}, status: "200" }
        payment_api = double(:payment_api, get_payments: payments)

        expected_response = { body: {:message=>"Payment not found"}, status: 404 }
        payment_getter = PaymentGetter.new(payment_api, "123")

        expect(payment_getter.get("bearer")).to eq expected_response
      end
    end
  end
end

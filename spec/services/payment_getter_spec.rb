require 'rails_helper'

describe PaymentGetter do
  describe "#get" do
    let(:body) { {"payments" => [{ "id" => "123"}]} }
    let(:status) { "200" }
    let(:payments) do
      {body: body, status: status}
    end

    let(:payment_api) do
      double(:payment_api, get_payments: payments)
    end

    subject { PaymentGetter.new(payment_api, "123") }

    context "when response status is 200" do
      it "returns the requested payment" do
        expected_response = { body: { "id" => "123"}, status: "200" }
        expect(subject.get("bearer")).to eq expected_response
      end
    end

    context "when the request is not authorized" do
      let(:body) { {"message" => "some message"} }
      let(:status) { "401" }

      it "returns 401" do
        expected_response = { body: {"message"=>"some message"}, status: "401" }
        expect(subject.get("bearer")).to eq expected_response
      end
    end

    context "when no payments are found" do
      let(:body) { {"payments" => [{"id" => "456"}]} }

      it "returns 404" do
        expected_response = { body: {:message=>"Payment not found"}, status: 404 }
        expect(subject.get("bearer")).to eq expected_response
      end
    end
  end
end

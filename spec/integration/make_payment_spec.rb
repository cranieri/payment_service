require 'rails_helper'

describe 'make payment' do
  let(:headers) do
    { 'Authorization' => "Bearer #{coolpay_api.access_token}" }
  end

  context "valid request" do
    let(:request_payload) do
      {
        payment: {
          amount: 10.50,
          currency: "GBP",
          recipient_id: coolpay_api.recipient_id
        }
    }
    end

    it "add payment recipients" do
      post '/payments', request_payload, headers
      payment_response = JSON.parse(response.body)["payment"]
      expect(payment_response).to include("status" => "processing")
      expect(payment_response).to include("recipient_id" => coolpay_api.recipient_id)
      expect(payment_response).to include("id" => anything)
      expect(payment_response).to include("currency" => "GBP")
      expect(payment_response).to include("amount" => "10.5")
    end
  end

  context "invalid request" do
    let(:request_payload) do
      {
        payment: {
          amount: 10.50,
          currency: currency,
          recipient_id: "fake"
        }
      }
    end

    let(:currency) { "GBP" }

    context "when recipient id is invalid" do
      it "returns 500" do
        post '/payments', request_payload, headers
        expect(JSON.parse(response.body)).to include("message" => "\"Internal server error\"")
        expect(response.status).to be 500
      end
    end

    context "when the currency is missing" do
      let(:currency) { nil }
      it "returns 422" do
        post '/payments', request_payload, headers
        expect(JSON.parse(response.body)).to include("errors" => {"currency"=>["can't be blank"]})
        expect(response.status).to be 422
      end
    end

    context "when the amount is missing" do
      let(:amount) { nil }
      it "returns 500" do
        post '/payments', request_payload, headers
        expect(JSON.parse(response.body)).to include("message" => "\"Internal server error\"")
        expect(response.status).to be 500
      end
    end

    context "wrong bearer token is provided" do
      let(:request_payload) do
        {
          payment: {
            amount: 10.50,
            currency: "GBP",
            recipient_id: coolpay_api.recipient_id
          }
      }
      end

      it "returns 401" do
        post '/payments', request_payload, { 'Authorization' => "Bearer wrong-token" }
        expect(JSON.parse(response.body)).to include("message" => "Please provide a good token")
        expect(response.status).to be 401
      end
    end
  end
end

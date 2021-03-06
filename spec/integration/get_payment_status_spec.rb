require 'rails_helper'

describe 'get payment status' do
  let(:headers) do
    { 'Authorization' => "Bearer #{coolpay_api.access_token}" }
  end

  it "add payment recipients" do
    get "/payments/#{coolpay_api.payment_id}", nil, headers
    payment_status_response = JSON.parse(response.body)["payment"]

    expect(payment_status_response).to include("status" => anything)
    expect(payment_status_response).to include("recipient_id" => coolpay_api.recipient_id)
    expect(payment_status_response).to include("id" => coolpay_api.payment_id)
    expect(payment_status_response).to include("currency" => "GBP")
    expect(payment_status_response).to include("amount" => "10.6")
  end

  context "wrong bearer token is provided" do
    it "returns 401" do
      get "/payments/#{coolpay_api.payment_id}", nil, { 'Authorization' => "Bearer wrong-token" }
      expect(JSON.parse(response.body)).to include("payment" => {"message"=>"Please provide a good token"})
      expect(response.status).to be 401
    end
  end
end

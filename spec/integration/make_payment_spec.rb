require 'rails_helper'

describe 'make payment' do
  let(:request_payload) do
    {
      payment: {
        amount: 10.50,
        currency: "GBP",
        recipient_id: coolpay_api.recipient_id
      }
  }
  end

  let(:headers) do
    { 'Authorization' => "Bearer #{coolpay_api.access_token}" }
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

  # def access_token
  #   @access_token ||= get_access_token
  # end
  #
  # def recipient_id
  #   @recipient_id ||= create_recipient
  # end
  #
  # def get_access_token
  #   authenticator = Authenticator.new(CoolpayApi.new)
  #   access_token = authenticator.authenticate('cosimo', '20F03CC806A81392')
  #   access_token["token"]
  # end
  #
  # def create_recipient
  #   recipient_creator = RecipientCreator.new(CoolpayApi.new)
  #   recipient = recipient_creator.create("John Doe", access_token)
  #   recipient["recipient"]["id"]
  # end
end

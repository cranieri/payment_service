require 'rails_helper'

describe 'add recipient' do
  let(:request_payload) do
    { recipient: { name: "John Doe" } }
  end

  let(:headers) do
    { 'Authorization' => "Bearer #{coolpay_api.access_token}" }
  end

  it "add payment recipients" do
    post '/recipients', request_payload, headers
    expect(JSON.parse(response.body)["recipient"]).to include("name" => "John Doe")
    expect(JSON.parse(response.body)["recipient"]).to include("id" => anything)
  end
end

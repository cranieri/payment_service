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

  it "returns 422 if the request payload is not valid" do
    post '/recipients', {surname: "surname"}, headers
    expect(JSON.parse(response.body)).to include("errors" => {"name"=>["can't be blank"]})
    expect(response.status).to be 422
  end

  context "wrong bearer token is provided" do
    it "returns 401" do
      post '/recipients', {surname: "surname"}, { 'Authorization' => "Bearer wrong-token" }
      expect(JSON.parse(response.body)).to include("message" => "Please provide a good token")
      expect(response.status).to be 401
    end
  end
end

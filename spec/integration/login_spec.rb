require 'rails_helper'

describe 'login' do
  it "returns a valid access token for coolpay api" do
    username = PaymentService::CONFIG["payment_api"]["username"]
    apikey = PaymentService::CONFIG["payment_api"]["apikey"]

    post '/login', {username: username, apikey: apikey}
    expect(JSON.parse(response.body)).to include("token" => anything)
    expect(response.status).to be 200
  end

  it "returns 404 if no valid credentials are provided" do
    post '/login', {username: "cosimo", apikey: "20F03CC806A81391"}
    expect(JSON.parse(response.body)).to include("message" => "\"Internal server error\"")
    expect(response.status).to be 404
  end

  it "returns 400 if the request payload is not valid" do
    post '/login', {apikey: "20F03CC806A81391"}
    expect(JSON.parse(response.body)).to include("message" => {"username"=>["can't be blank"]})
    expect(response.status).to be 400
  end
end

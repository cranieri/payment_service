require 'rails_helper'

describe 'login' do
  it "returns a token" do
    post '/login', {username: "cosimo", apikey: "20F03CC806A81392"}
    expect(JSON.parse(response.body)).to include("token" => anything)
  end
end

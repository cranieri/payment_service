require 'rails_helper'

describe LoginController do
  describe "POST#create" do
    before do
      response = { body: {"token" => "12345"}, status: 200 }
      expect_any_instance_of(CoolpayApi).to receive(:login).and_return(response)
    end

    it "returns status 200" do
      post :create, {username: "cosimo", apikey: "20F03CC806A81392"}
      expect(response.status).to eq 200
    end

    it "returns a token" do
      expected_response = {"token" => "12345"}
      post :create, {username: "cosimo", apikey: "20F03CC806A81392"}
      expect(JSON.parse(response.body)).to eq expected_response
    end
  end
end

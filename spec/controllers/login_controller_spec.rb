require 'rails_helper'

describe LoginController do
  describe "POST#create" do
    context "with valid payload" do
      let(:request_payload) do
        {username: "cosimo", apikey: "20F03CC806A81392"}
      end

      before do
        response = { body: {"token" => "12345"}, status: 200 }
        expect_any_instance_of(CoolpayApi).to receive(:login).and_return(response)
        post :create, request_payload
      end

      it "returns status 200" do
        expect(response.status).to eq 200
      end

      it "returns a token" do
        expected_response = {"token" => "12345"}
        expect(JSON.parse(response.body)).to eq expected_response
      end
    end

    context "with invalid payload" do
      before do
        messages = double(:messages, messages: "messages")
        login_validator = double(:login_validator, :valid? => false, errors: messages)
        expect(LoginValidator).to receive(:new).and_return(login_validator)
      end

      it "returns status 400" do
        expected_response = {"message" => "messages"}
        post :create, {apikey: "20F03CC806A81392"}
        expect(JSON.parse(response.body)).to eq expected_response
        expect(response.status).to be 400
      end
    end
  end
end

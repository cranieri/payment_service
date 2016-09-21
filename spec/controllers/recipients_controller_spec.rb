require 'rails_helper'

describe RecipientsController do
  describe "POST#create" do
    let(:recipient_response) do
      {
        "recipient" => {
          "name" => "John Doe",
          "id" => "some-id"
        }
      }
    end

    let(:expected_response) do
      { body: recipient_response, status: 201 }
    end

    let(:request_payload) do
      { recipient: { name: "John Doe" } }
    end

    before do
      request.env["HTTP_AUTHORIZATION"] = "Bearer token"
      expect_any_instance_of(CoolpayApi).to receive(:recipients).and_return(expected_response)
    end

    it "returns status 201" do
      post :create, request_payload
      expect(response.status).to eq 201
    end

    it "returns the created recipient" do
      post :create, request_payload
      expect(JSON.parse(response.body)).to eq recipient_response
    end
  end
end

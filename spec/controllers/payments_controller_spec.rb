require 'rails_helper'

describe PaymentsController do
  describe "POST#create" do
    let(:payment_response) do
      {
        "payment" => {
          "status" => "processing",
          "recipient_id" => "rec-id",
          "id" => "payment-id",
          "currency" => "GBP",
          "amount" => "10.5"
        }
      }
    end

    let(:expected_response) do
      { body: payment_response, status: 201 }
    end

    let(:request_payload) do
      {
        "payment" => {
          "amount" => 10.50,
          "currency" => "GBP",
          "recipient_id" => "rec-id"
        }
      }
    end

    before do
      request.env["HTTP_AUTHORIZATION"] = "Bearer token"
      expect_any_instance_of(CoolpayApi).to receive(:payments).and_return(expected_response)
    end

    it "returns status 201" do
      post :create, request_payload
      expect(response.status).to eq 201
    end

    it "returns the payment that have been made" do
      post :create, request_payload
      expect(JSON.parse(response.body)).to eq payment_response
    end
  end

  describe "GET#show" do
    let(:payment_response) do
      {
        "payment" => {
          "status" => "processing",
          "recipient_id" => "rec-id",
          "id" => "payment-id",
          "currency" => "GBP",
          "amount" => "10.5"
        }
      }
    end

    let(:expected_response) do
      { body: payment_response, status: 200 }
    end

    let(:api_response) do
      {
        "status" => "processing",
        "recipient_id" => "rec-id",
        "id" => "payment-id",
        "currency" => "GBP",
        "amount" => "10.5"
      }
    end

    let(:full_response) do
      { body: api_response, status: 200 }
    end

    let(:request_params) do
      {id: "payment-id"}
    end

    before do
      request.env["HTTP_AUTHORIZATION"] = "Bearer token"
      expect_any_instance_of(PaymentGetter).to receive(:get).and_return(full_response)
    end

    it "returns status 201" do
      get :show, request_params
      expect(response.status).to eq 200
    end

    it "returns the payment that have been made" do
      get :show, request_params
      expect(JSON.parse(response.body)).to eq payment_response
    end
  end
end

require 'rails_helper'
require 'net/http'

describe JsonRequest do
  describe "#format_response" do
    subject { JsonRequest.new("http://www.someurl.com/some", :get, {}) }

    context "with valid json response" do
      let(:response_body) do
        '{ "response": "I\'m going home" }'
      end

      let(:expected_json) do
        { "response" => 'I\'m going home' }
      end

      it "formats the response from meetup" do
        expect(subject.format_response(response_body)).to eq expected_json
      end
    end

    context "with invalid json response" do
      let(:response_body) do
        'invalid json'
      end

      let(:expected_json) do
        { :message => "invalid json" }
      end

      it "formats the response from meetup" do
        expect(subject.format_response(response_body)).to eq expected_json
      end
    end

  end
end

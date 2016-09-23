require 'net/http'
require './app/api/http_request'

describe HttpRequest do
  describe "#make_request" do
    subject { HttpRequest.new('https://www.someurl.com/some', http_verb, {"Header"=>"some header"}) }

    let(:request_body) { {param: 'some param'} }
    let(:request) { double('request', :body= => { attr: 'attribute'}) }
    let(:response) { double('request', body: true, code: 200) }
    let(:expected_headers) { {"Accept-Charset"=>"UTF-8", "Content-Type"=>"application/json", "Header"=>"some header"} }

    before do
      expect_any_instance_of(Net::HTTP).to receive(:request).and_return(response)
    end

    context 'get request' do
      let(:http_verb) { 'get' }
      it 'make a request to the provided url' do
        expect(Net::HTTP::Get).to receive(:new).with("/some", expected_headers).and_return(request)
        subject.make_request(request_body)
      end
    end

    context 'post request' do
      let(:http_verb) { 'post' }
      it 'make a request to the provided url' do
        expect(Net::HTTP::Post).to receive(:new).with("/some", expected_headers).and_return(request)
        subject.make_request(request_body)
      end
    end
  end
end

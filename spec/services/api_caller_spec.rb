require 'rails_helper'

describe ApiCaller do
  it "sets up the api request with right params and headers" do
    api_caller = ApiCaller.new("http://some_api.com/")
    json_request = double('json_request', make_request: true)
    expect(JsonRequest).to receive(:new).and_return(json_request)
    api_caller.login({"param" => "123"}, "post")
  end
end

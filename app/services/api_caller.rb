class ApiCaller
  attr_reader :request_class

  def initialize(api_url, request_class: "JsonRequest")
    @api_url = api_url
    @request_class = request_class
  end

  def method_request(method, params, http_verb, headers = {})
    http_headers = headers || {}
    http_request = http_request_class.new("#{@api_url}#{method}", http_verb, http_headers)
    http_request.make_request(params)
  end

  def method_missing(method, *args, &block)
    self.method_request(method, args[0], args[1], args[2])
  end

private
  def http_request_class
    Object.const_get(request_class)
  end
end

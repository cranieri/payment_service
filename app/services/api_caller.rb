class ApiCaller
  def initialize(api_url)
    @api_url = api_url
  end

  def method_request(method, params, http_verb, headers = {})
    http_headers = headers || {}
    json_request = JsonRequest.new("#{@api_url}#{method}", http_verb, http_headers)
    requester = HttpRequester.new(json_request)
    requester.execute_request(params)
  end

  def method_missing(method, *args, &block)
    self.method_request(method, args[0], args[1], args[2])
  end
end

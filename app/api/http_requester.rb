class HttpRequester
  def initialize(requester)
    @requester = requester
  end

  def execute_request(body)
    @requester.make_request(body)
  end
end

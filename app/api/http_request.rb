require 'net/http'
require 'json'

class HttpRequest
  attr_reader :http_verb, :http_headers, :uri

  def initialize(uri, http_verb, http_headers)
    @http_verb = http_verb
    @http_headers = http_headers

    @uri = URI.parse(uri)
  end

  def make_request(body)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = http_client.new(uri.path, headers)
    request.body = body.to_json
    response = http.request(request)
    {status: response.code, body: format_response(response.body)}
  end

  def format_response(response_body); response_body; end;

  private

  def headers
    { 'Accept-Charset' => 'UTF-8', 'Content-Type' => 'application/json' }.merge(http_headers)
  end

  def http_client
    Net::HTTP.const_get(http_verb.capitalize)
  end
end

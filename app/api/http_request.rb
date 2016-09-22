require 'net/http'

class HttpRequest
  CHARSET = 'UTF-8'
  CONTENT_TYPE = 'application/json'
  attr_reader :in_uri, :http_verb, :http_headers

  def initialize(uri, http_verb, http_headers)
    @in_uri = uri
    @http_verb = http_verb
    @http_headers = http_headers
  end

  def make_request(body)
    uri = URI.parse(in_uri)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = class_to_call.new(uri.path, headers)
    request.body = body.to_json
    response = http.request(request)
    {status: response.code, body: format_response(response.body)}
  end

  def format_response(response_body); response_body; end;

  private

  def headers
    { 'Accept-Charset' => CHARSET, 'Content-Type' => CONTENT_TYPE }.merge(http_headers)
  end

  def class_to_call
    Net::HTTP.const_get(http_verb.capitalize)
  end
end

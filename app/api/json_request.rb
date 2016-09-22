class JsonRequest < HttpRequest
  def format_response(response_body)
      JSON.parse(response_body)
    rescue JSON::ParserError => e
      {message: response_body}
  end
end

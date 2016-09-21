class Authenticator
  attr_reader :api
  def initialize(api)
    @api = api
  end

  def authenticate(username, apikey)
    api.login({username: username, apikey: apikey})
  end
end

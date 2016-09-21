class RecipientCreator
  attr_reader :api
  def initialize(api)
    @api = api
  end

  def create(name, bearer_token)
    api.recipients({ recipient: { name: name } }, { "Authorization" => "Bearer #{bearer_token}" })
  end
end

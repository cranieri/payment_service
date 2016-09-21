class PaymentMaker
  attr_reader :api
  def initialize(api)
    @api = api
  end

  def make(amount, currency, recipient_id, bearer_token)
    api.payments({payment: {amount: amount, currency: currency, recipient_id: recipient_id}}, {"Authorization" => "Bearer #{bearer_token}"})
  end
end

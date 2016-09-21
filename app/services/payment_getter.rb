class PaymentGetter
  attr_reader :api
  def initialize(api)
    @api = api
  end

  def get(payment_id, bearer_token)
    payments = api.get_payments({ "Authorization" => "Bearer #{bearer_token}" })
    payment = payments[:body]["payments"].select { |payment| payment["id"] == payment_id }
  end
end

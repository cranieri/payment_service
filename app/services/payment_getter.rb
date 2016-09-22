class PaymentGetter
  attr_reader :api

  def initialize(api)
    @api = api
  end

  def get(payment_id, bearer_token)
    payments = api.get_payments({ "Authorization" => "Bearer #{bearer_token}" })

    if (payments[:status] == "401")
      { body: payments[:body], status: payments[:status] }
    else
      get_payment_response(payments, payment_id)
    end
  end

private

  def get_payment_response(payments, payment_id)
    if payments[:body]["payments"]
      matched_payments = payments[:body]["payments"].select { |payment| payment["id"] == payment_id }
      { body: matched_payments[0], status: payments[:status] }
    else
      { body: "Payment not found", status: 404 }
    end
  end
end

class PaymentGetter
  attr_reader :api, :payment_id

  def initialize(api, payment_id)
    @api = api
    @payment_id = payment_id
  end

  def get(authorization_header)
    payments = api.get_payments(authorization_header)
    if (payments[:status] == "401")
      { body: payments[:body], status: payments[:status] }
    else
      get_payment_response(payments)
    end
  end

private

  def get_payment_response(payments)
    if matched_payment = matched_payment(payments)
      { body: matched_payment, status: payments[:status] }
    else
      { body: {message: "Payment not found"}, status: 404 }
    end
  end

  def matched_payment(payments)
    payments[:body]["payments"].select { |payment| payment["id"] == payment_id }.first
  end
end

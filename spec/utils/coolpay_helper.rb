class CoolpayHelper
  def access_token
    @access_token ||= get_access_token
  end

  def recipient_id
    @recipient_id ||= create_recipient
  end

  def payment_id
    @payment_id ||= get_payment_id
  end

  def get_payment_id
    payment = coolpay_api.payments(payment_create_params, bearer_token)
    payment[:body]["payment"]["id"]
  end

  def get_access_token
    access_token = coolpay_api.login({username: username, apikey: apikey})
    access_token[:body]["token"]
  end

  def create_recipient
    recipient = coolpay_api.recipients({recipient: {name: "John Doe"}}, bearer_token)
    recipient[:body]["recipient"]["id"]
  end

private

  def bearer_token
    { "Authorization" => "Bearer #{access_token}" }
  end

  def payment_create_params
    {payment: {amount: "10.6", currency: "GBP", recipient_id: recipient_id}}
  end

  def username
    PaymentService::CONFIG["payment_api"]["username"]
  end

  def apikey
    PaymentService::CONFIG["payment_api"]["apikey"]
  end

  def coolpay_api
    @coolpay_api ||= CoolpayApi.new(ApiAdaptor.new(PaymentService::CONFIG["payment_api"]["url"]))
  end
end

class CoolpayApi
  BASE_URL = 'https://coolpay.herokuapp.com/api/'

  def login(params)
    api_caller.login(params, :post)
  end

  def recipients(params, headers)
    api_caller.recipients(params, :post, headers)
  end

  def payments(params, headers)
    api_caller.payments(params, :post, headers)
  end

  def get_payments(headers)
    api_caller.payments({}, :get, headers)
  end

  def api_caller
    ApiCaller.new("#{BASE_URL}")
  end
end

class CoolpayApi
  attr_reader :api_adaptor

  def initialize(api_adaptor)
    @api_adaptor = api_adaptor
  end

  def login(params)
    api_adaptor.login(params, :post)
  end

  def recipients(params, headers)
    api_adaptor.recipients(params, :post, headers)
  end

  def payments(params, headers)
    api_adaptor.payments(params, :post, headers)
  end

  def get_payments(headers)
    api_adaptor.payments({}, :get, headers)
  end
end

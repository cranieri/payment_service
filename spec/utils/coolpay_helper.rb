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
    payment_maker = PaymentMaker.new(CoolpayApi.new)
    payment = payment_maker.make("10.6", "GBP", recipient_id, access_token)
    payment[:body]["payment"]["id"]
  end

  def get_access_token
    authenticator = Authenticator.new(CoolpayApi.new)
    access_token = authenticator.authenticate('cosimo', '20F03CC806A81392')
    access_token[:body]["token"]
  end

  def create_recipient
    recipient_creator = RecipientCreator.new(CoolpayApi.new)
    recipient = recipient_creator.create("John Doe", access_token)
    recipient[:body]["recipient"]["id"]
  end
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery unless: -> { request.format.json? }

  def payment_api
    CoolpayApi.new(ApiAdaptor.new(PaymentService::CONFIG["payment_api"]["url"]))
  end

  def authorization_header
    {"Authorization" => "Bearer #{bearer_token}"}
  end

private

  def bearer_token
    request.headers["HTTP_AUTHORIZATION"].split(" ")[1] if request.headers["HTTP_AUTHORIZATION"]
  end
end

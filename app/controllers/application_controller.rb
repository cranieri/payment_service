class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def payment_api
    CoolpayApi.new
  end

  def bearer_token
    request.headers["HTTP_AUTHORIZATION"].split(" ")[1] if request.headers["HTTP_AUTHORIZATION"]
  end
end

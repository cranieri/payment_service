class LoginController < ApplicationController
  def create
    request_validator = LoginValidator.new(username: username, apikey: apikey)
    if request_validator.valid?
      authenticate = payment_api.login({username: username, apikey: apikey})
      render json: authenticate[:body], status: authenticate[:status]
    else
      render json: {message: request_validator.errors.messages}, status: 400
    end
  end

private

  def username
    params[:username]
  end

  def apikey
    params[:apikey]
  end
end

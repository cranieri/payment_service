class LoginController < ApplicationController
  def create
    authenticate = coolpay_api.login({username: username, apikey: apikey})
    render json: authenticate[:body], status: authenticate[:status]
  end

private
  def username
    params[:username]
  end

  def apikey
    params[:apikey]
  end
end

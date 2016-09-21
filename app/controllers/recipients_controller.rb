class RecipientsController < ApplicationController
  def create
    recipient = coolpay_api.recipients({recipient: {name: recipient_name}}, {"Authorization" => "Bearer #{bearer_token}"})
    render json: recipient[:body], status: recipient[:status]
  end

private

  def recipient_name
    params[:recipient][:name]
  end

  def bearer_token
    request.headers["HTTP_AUTHORIZATION"].split(" ")[1]
  end
end

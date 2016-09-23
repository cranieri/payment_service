class RecipientsController < ApplicationController
  def create
    recipient = payment_api.recipients(recipient_params, authorization_header)
    render json: recipient[:body], status: recipient[:status]
  end

private
  def recipient_params
    {recipient: {name: recipient_name}}
  end
  
  def recipient_name
    params[:recipient][:name] if params[:recipient]
  end
end

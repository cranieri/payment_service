class PaymentsController < ApplicationController
  def create
    payment = payment_api.payments(payment_create_params, authorization_header)
    render json: payment[:body], status: payment[:status]
  end

  def show
    payment_getter = PaymentGetter.new(CoolpayApi.new)
    payment = payment_getter.get(payment_id, bearer_token)
    render json: { payment: payment[:body] } , status: payment[:status]
  end

private

  def authorization_header
    {"Authorization" => "Bearer #{bearer_token}"}
  end

  def payment_create_params
    {payment: {amount: amount, currency: currency, recipient_id: recipient_id}}
  end

  def amount
    params[:payment][:amount]
  end

  def currency
    params[:payment][:currency]
  end

  def recipient_id
    params[:payment][:recipient_id]
  end

  def payment_id
    params[:id]
  end
end

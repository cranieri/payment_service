class PaymentsController < ApplicationController
  def create
    payment = payment_api.payments(payment_create_params, authorization_header)
    render json: payment[:body], status: payment[:status]
  end

  def show
    payment_getter = PaymentGetter.new(payment_api, payment_id)
    payment = payment_getter.get(authorization_header)
    render json: { payment: payment[:body] } , status: payment[:status]
  end

private

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

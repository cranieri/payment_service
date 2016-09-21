class PaymentsController < ApplicationController
  def create
    payment = coolpay_api.payments(payment_create_params, {"Authorization" => "Bearer #{bearer_token}"})
    render json: payment[:body], status: payment[:status]
  end

  def show
    payment_getter = PaymentGetter.new(CoolpayApi.new)
    payments = payment_getter.get(payment_id, bearer_token)
    if (payments.size > 0)
      render json: { payment: payments[0] } , status: 200
    else
      render json: { message: "Payment not found" } , status: 404
    end
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

  def bearer_token
    request.headers["HTTP_AUTHORIZATION"].split(" ")[1]
  end
end

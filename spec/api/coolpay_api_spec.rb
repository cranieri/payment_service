require 'rails_helper'

describe CoolpayApi do
  subject { CoolpayApi.new(api_adaptor) }

  let(:api_adaptor) { double(:api_adaptor, login: true, recipients: true, payments: true, get_payments: true)}

  let(:params) { {params: "param"} }
  let(:headers) { {header: "header"} }

  describe "#login" do
    it "calls api adapter login method" do
      expect(api_adaptor).to receive(:login).with(params, :post)
      subject.login(params)
    end
  end

  describe "#recipients" do
    it "calls api adapter recipients method" do
      expect(api_adaptor).to receive(:recipients).with(params, :post, headers)
      subject.recipients(params, headers)
    end
  end

  describe "#payments" do
    it "calls api adapter payments method" do
      expect(api_adaptor).to receive(:payments).with(params, :post, headers)
      subject.payments(params, headers)
    end
  end

  describe "#get_payments" do
    it "calls api adapter get_payments method" do
      expect(api_adaptor).to receive(:payments).with({}, :get, headers)
      subject.get_payments(headers)
    end
  end
end

require "rails_helper"

describe LoginValidator do
  subject { LoginValidator.new(username: username, apikey: apikey) }

  context "valid login" do
    let(:username) { "someusername" }
    let(:apikey) { "23432" }

    describe "#valid?" do
      it { expect(subject.valid?).to be true }
    end

    describe "#errors" do
      it "returns an empty array" do
        subject.valid?
        expect(subject.errors).to be_empty
      end
    end
  end

  context "invalid login" do
    let(:username) { nil }
    let(:apikey) { "23432" }

    describe "#valid?" do
      it { expect(subject.valid?).to be false }
    end

    describe "#errors" do
      it "returns an array with the errors" do
        expected_errors = {username: ["can't be blank"]}
        subject.valid?
        expect(subject.errors.messages).to eq expected_errors
      end
    end
  end
end

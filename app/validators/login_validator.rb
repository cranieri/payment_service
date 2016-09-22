class LoginValidator < OpenStruct
  include ActiveModel::Validations

  validates_presence_of :username
  validates_presence_of :apikey
end

class User < ApplicationRecord
  include Role

  has_secure_password validations: false
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: -> { _1.strip.downcase }

  def current?
    self == Current.user
  end
end

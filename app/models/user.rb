class User < ApplicationRecord
  include Role

  has_secure_password validations: false
  has_many :sessions, dependent: :destroy

  # has_one :organization, dependent: :destroy
  has_one :administratorship, dependent: :destroy
  has_one :organization, through: :administratorship

  has_many :accesses, dependent: :destroy
  has_many :patient_records, through: :accesses

  normalizes :email_address, with: -> { _1.strip.downcase }

  def current?
    self == Current.user
  end

  def can_manage?
    administratorship.can_manage?
  end

  def owner?
    administratorship.owner?
  end

  def deactivate
    transaction do
      sessions.delete_all
      administratorship.delete
      update! active: false, email_address: deactived_email_address
    end
  end

  private
    def deactived_email_address
      email_address&.gsub(/@/, "-deactivated-#{SecureRandom.uuid}@")
    end
end

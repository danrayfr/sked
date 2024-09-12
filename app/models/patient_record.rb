class PatientRecord < ApplicationRecord
  include Accessable
  belongs_to :organization
  has_many :accesses

  scope :ordered, -> { order(created_at: :desc) }

  validates_presence_of :name, :email_address, :date, :procedure
end

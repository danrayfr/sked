class PatientRecord < ApplicationRecord
  include Accessable
  belongs_to :organization
  has_many :accesses

  validates_presence_of :name, :email_address, :date, :procedure
end

class PatientRecord < ApplicationRecord
  belongs_to :organization

  validates_presence_of :name, :email_address, :date, :procedure
end

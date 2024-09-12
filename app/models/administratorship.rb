class Administratorship < ApplicationRecord
  include Role

  belongs_to :user
  belongs_to :organization

  validates :user_id, uniqueness: { message: "is already an administrator of an organization." }

  scope :ordered, -> {
    order(
      Arel.sql("CASE WHEN role = 'owner' THEN 1 WHEN role = 'staff' THEN 2 WHEN role = 'patient' THEN 3 ELSE 4 END"),
      created_at: :desc
    )
  }
end

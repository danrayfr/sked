class Administratorship < ApplicationRecord
  include Role

  belongs_to :user
  belongs_to :organization

  validates :user_id, uniqueness: { message: "is already an administrator of an organization." }
end

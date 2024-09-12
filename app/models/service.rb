class Service < ApplicationRecord
  belongs_to :organization

  # has_one_attached :cover, dependent: :purge_later
  normalizes :name, with: ->(name) { name.downcase }
  validates :name, presence: true, uniqueness: { scope: :organization }
end

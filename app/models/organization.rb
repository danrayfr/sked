class Organization < ApplicationRecord
  include Sluggable, Joinable, Findable

  belongs_to :user
  validates :name, presence: true, uniqueness: true
end

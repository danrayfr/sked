class Organization < ApplicationRecord
  include Sluggable, Joinable, Findable

  belongs_to :user
  has_many :patient_records, dependent: :destroy
  has_many :administratorships, dependent: :destroy
  has_many :users, through: :administratorships
  has_many :services, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  after_create :assign_administrator

  private
    def assign_administrator
      Administratorship.create!(user: user, organization: self, role: :owner)
    end
end

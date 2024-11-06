class Access < ApplicationRecord
  belongs_to :user
  belongs_to :patient_record
  enum :level, %w[ reader editor ].index_by(&:itself)
end

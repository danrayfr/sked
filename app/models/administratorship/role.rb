module Administratorship::Role
  extend ActiveSupport::Concern

  included do
    enum :role, %i[ patient staff owner ], default: :patient
  end

  def can_manage?
    owner? || staff?
  end
end

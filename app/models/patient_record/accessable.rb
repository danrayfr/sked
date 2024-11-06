module PatientRecord::Accessable
  extend ActiveSupport::Concern

  included do
    has_many :accesses, dependent: :destroy
  end

  class_methods do
    def accessable(user: Current.user)
      if user.present?
        accessable_patient_records
      end
    end

    def accessable_patient_records(user: Current.user)
      user.patient_records.distinct
    end
  end

  def accessable?(user: Current.user)
    accesses.exists?(user: user)
  end

  def editable?(user: Current.user)
    access_for(user: user)&.editor?
  end

  def access_for(user: Current.user)
    accesses.find_by(user: user)
  end

  def update_access(editors:, readers:)
    # editors = Set.new(editors)
    editors = Set.new((Current.organization.users.where(administratorships: { role: "owner" }).ids + editors.to_a).uniq)
    readers = (Current.organization.users.where(administratorships: { role: "owner" }).ids + readers).uniq

    all = editors + readers
    all_accesses = all.collect { |user_id|
      { user_id: user_id, level: editors.include?(user_id) ? :editor : :reader }
    }

    accesses.upsert_all(all_accesses, unique_by: [ :patient_record_id, :user_id])
    accesses.where.not(user_id: all).delete_all
  end
end

class PatientRecordsController < ApplicationController
  before_action :require_authentication

  before_action :set_organization
  before_action :set_record, only: %i[ show edit update destroy ]
  before_action :ensure_can_manage?, only: %i[ edit new edit update destroy ]
  before_action :ensure_editable, only: %i[ edit update destroy ]
  before_action :set_users, only: %i[ edit ]

  def index
    @patient_records = Current.organization.patient_records.accessable.ordered
  end

  def show
  end

  def new
    @patient_record = @organization.patient_records.build
  end

  def create
    @patient_record = @organization.patient_records.build(record_params)

    if @patient_record.save
      update_accesses(@patient_record)
      redirect_to organization_patient_records_path(@organization.uid), notice: "Record saved."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @patient_record.update(record_params)
      update_accesses(@patient_record)
      redirect_to organization_patient_record_path(@organization.uid, @patient_record), notice: "Record updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @patient_record.destroy

    redirect_to slugged_organization_patient_records_url(@organization), notice: "Record successfully deleted."
  end

  private
    def record_params
      params.require(:patient_record).permit(:name, :email_address, :date, :procedure)
    end

    def set_organization
      @organization = Current.organization
    end

    def set_record
      @patient_record = PatientRecord.accessable.find params[:id]
    end

    def set_users
      @users = Current.organization.users
    end

    def ensure_editable
      head :forbidden unless @patient_record.editable?
    end

    def update_accesses(record)
      editors = [ Current.user.id, *params[:editor_ids]&.map(&:to_i) ]
      readers = [ Current.user.id, *params[:reader_ids]&.map(&:to_i) ]

      record.update_access(editors: editors, readers: readers)
    end
end

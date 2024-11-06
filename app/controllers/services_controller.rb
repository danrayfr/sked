class ServicesController < ApplicationController
  before_action :require_authentication
  # before_action :ensure_can_manage?
  # before_action :validate_organization, only: %i[ index new edit ]
  before_action :set_organization
  before_action :set_service, only: %i[ edit update destroy ]

  def index
    @services = @organization.services.ordered
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params.merge(organization: @organization))

    if @service.save
      redirect_to organization_services_path(@organization.uid)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @service.update(service_params)
      redirect_to organization_services_path(@organization.uid), notice: "Updated successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @service.destroy
    redirect_to organization_services_path(@organization.uid)
  end

  private
    def service_params
      params.require(:service).permit(:name, :description, :cost, :organization_id)
    end

    def validate_organization
      @organization = Organization.find_by(uid: params[:uid])

      head :not_found if @organization.nil?
    end

    def set_organization
      @organization = Organization.find_by(uid: params[:organization_uid])
    end

    def set_service
      @service = Service.find params[:id]
    end
end

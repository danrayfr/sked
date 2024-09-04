class OrganizationsController < ApplicationController
  allow_unauthenticated_access only: :show

  before_action :current_organization, only: :index
  before_action :redirect_to_form_if_no_organization, only: :new
  before_action :find_organization, only: :show
  before_action :set_organization, only: %i[ edit update destroy ]
  before_action :ensure_can_manage?, only: %i[ edit update destroy ]
  before_action :resume_session

  def index
  end

  def new
    @organization = Organization.new
  end

  def create
    Organization.create!(organization_params.merge(user: Current.user))

    redirect_to root_url
  end

  def show
  end

  def edit
  end

  def update
    if @organization.update! organization_params
      redirect_to root_url, notice: "Successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @organization.destroy
    redirect_to root_url
  end

  private
    def redirect_to_form_if_no_organization
      redirect_to root_url if Current.organization.present?
    end

    def find_organization
      @organization = Organization.find_by_uid(params[:uid]) ||
                      Organization.find_by_slug(params[:slug])
    end

    def set_organization
      @organization = Organization.find(params[:id])
    end

    def organization_params
      params.require(:organization).permit(:name, :slug)
    end

    def current_organization
      @organization = Current.organization

      redirect_to new_organization_url if @organization.nil?
    end
end

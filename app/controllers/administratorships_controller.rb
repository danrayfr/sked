class AdministratorshipsController < ApplicationController
  before_action :require_authentication

  before_action :set_organization
  before_action :set_administratorships, only: :index
  before_action :set_administratorship, only: %i[ edit update ]

  def index
  end

  def edit
  end

  def update
    @administratorship.update(role_params)
    redirect_to slugged_organization_administratorships_url(@organization.uid)
  end

  private
    def role_params
      { role: params.require(:administratorship)[:role].presence_in(%w[patient staff owner]) || "patient" }
    end

    def set_organization
      @organization = Current.organization
    end

    def set_administratorships
      @administatorhips = @organization.administratorships
    end

    def set_administratorship
      @administratorship = Administratorship.find params[:id]
    end
end

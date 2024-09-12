class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]

  before_action :verify_join_code, only: %i[ new create ]

  before_action :resume_session, only: :new
  before_action :redirect_authenticated?, only: :new
  before_action :set_user, only: %i[ update destroy ]
  before_action :check_if_patient, only: :index
  before_action :ensure_can_manage?, only: %i[ index destroy ]
  rate_limit to: 10, within: 1.minute, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later" }

  def index
    @users = Current.organization.users
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create! user_params
    Administratorship.create!(organization: @organization, user: @user, role: :patient)
    start_new_session_for @user
    redirect_to root_url
  rescue ActiveRecord::RecordNotUnique
    redirect_to new_session_url(email_address: user_params[:email_address])
  end

  def update
    @user.update(role_params)
    redirect_to users_url
  end

  def destroy
    @user.deactivate
    redirect_to users_url
  end

  private
    def role_params
      { role: params.require(:user)[:role].presence_in(%w[member administrator ]) || "member" }
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email_address, :password)
    end

    def redirect_authenticated?
      redirect_to root_url if authenticated?
    end

    def verify_join_code
      @organization = Organization.find_by(uid: params[:uid])
      head :not_found if @organization.nil? || @organization.join_code != params[:join_code]
    end

    def check_if_patient
      redirect_to root_url if Current.user&.administratorship.patient?
    end
end

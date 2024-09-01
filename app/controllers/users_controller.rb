class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 3, within: 1.minute, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later" }
  before_action :resume_session, only: :new
  before_action :redirect_authenticated?, only: :new

  def new
    @user = User.new
  end

  def create
    @user = User.create! user_params
    start_new_session_for @user
    redirect_to root_url
  rescue ActiveRecord::RecordNotUnique
    redirect_to new_session_url(email_address: user_params[:email_address])
  end

  private
    def user_params
      params.require(:user).permit(:name, :email_address, :password)
    end

    def redirect_authenticated?
      redirect_to root_url if authenticated?
    end
end

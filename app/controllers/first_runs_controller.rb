class FirstRunsController < ApplicationController
  allow_unauthenticated_access

  def show
    @user = User.new
  end

  def create
    organization_name = params[:user][:organization_name]

    if organization_name.blank?
      render :show
    end

    user = FirstRun.create!(user_params, organization_name)
    start_new_session_for user

    redirect_to root_url
  end

  private
    def user_params
      params.require(:user).permit(:name, :email_address, :password)
    end
end

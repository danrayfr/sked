class Users::ProfilesController < ApplicationController
  include UserScoped

  before_action :ensure_current_user, only: %i[ show edit update ]

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_profile_url(@user), notice: "Profile updated successfully."
    else
      render :edit, alert: @user.errors.full_messages.to_sentence
    end
  end

  private
    def ensure_current_user
      head :forbidden unless @user.current?
    end

    def user_params
      params.require(:user).permit(:email_address, :password, :current_password)
    end
end

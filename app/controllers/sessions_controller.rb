class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { render_rejection :too_many_requests }

  def new
  end

  def create
    if user = User.authenticate_by(user_params)
      start_new_session_for user
      redirect_to after_authentication_url
    else
      redirect_to new_session_url, alert: "Try another email address or password."
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_url
  end

  private
    def user_params
      params.permit(:email_address, :password)
    end

    def render_rejection(status)
      flash[:alert] = "Too many requests or unauthorized."
      render :new, status: status
    end
end

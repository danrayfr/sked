class Organizations::JoinCodesController < ApplicationController
  before_action :ensure_can_manage?

  def create
    Current.organization.reset_join_code
    redirect_to users_path
  end
end

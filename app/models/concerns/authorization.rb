module Authorization
  private
    def ensure_can_manage?
      head :forbidden unless Current.user&.administratorship&.can_manage?
    end

    def ensure_current_user
      head :forbidden unless @user.current?
    end
end

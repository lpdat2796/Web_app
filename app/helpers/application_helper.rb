# frozen_string_literal: true

module ApplicationHelper
  def show_left_menu?
    !request.path.in? [new_user_session_path,login_path, register_path, password_reset_path, new_user_confirmation_path, user_confirmation_path]
  end
end

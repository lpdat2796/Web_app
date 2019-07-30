module ApplicationHelper
    def show_left_menu?
        !request.path.in? [login_path, register_path, password_reset_path]
    end
end

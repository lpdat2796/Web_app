class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :username, :password, :password_confirmation])
  end

  def after_sign_in_path_for(resource)
    if current_user.role == 1
      admin_root_path
    else
      search_index_path
    end 
  end
  def after_sign_out_path_for(resource)
    login_path
  end

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to login_path, :notice => 'You need to sign in or sign up before continuing.'
    end
  end 
end

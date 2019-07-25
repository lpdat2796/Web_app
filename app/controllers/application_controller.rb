class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
  
    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) do |u|
        u.permit(:email, :username, :password, :password_confirmation)
    
      end
    end
  end
end

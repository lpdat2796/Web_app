class Admin::BaseController < ApplicationController
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :ensure_user_accessible

  private
  def ensure_user_accessible
    return if current_user.is_admin? 
    redirect_to search_index_path 
  end
end
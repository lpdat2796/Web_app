class Admin::BaseController < ApplicationController
  before_action :ensure_user_accessible

  private
  def ensure_user_accessible
    return if current_user.is_admin? 
    redirect_to search_path 
  end
end
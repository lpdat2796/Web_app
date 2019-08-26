# frozen_string_literal: true

class Admin::BaseController < ApplicationController
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :ensure_user_accessible
  if @user.nil?
    skip_authorize_resource if @user.nil?
  else 
    load_and_authorize_resource
  end
  private

  def ensure_user_accessible
    return if current_user.is_admin?

    redirect_to root_path
  end
end

# frozen_string_literal: true

class Admin::BaseController < ApplicationController
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :ensure_user_accessible
  load_and_authorize_resource

  private

  def ensure_user_accessible
    return if current_user&.is_admin?

    redirect_to root_path
  end
end

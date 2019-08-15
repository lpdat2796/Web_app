# frozen_string_literal: true

module ApplicationHelper
  def show_left_menu?
    !devise_controller?
  end
end

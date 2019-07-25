class AdminController < ApplicationController
  
  def index
    @user = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find_by id: params[:id]
  end
end

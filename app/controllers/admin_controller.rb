class AdminController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  # def login;end

  def index
    @user = User.all
  end

  def new
    @usert = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @user = User.find_by(params[:id])
    byebug
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_index_path, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private
  def set_user
    @user = User.find_by(params[:id])
  end
  def user_params
    params.require(:user).permit(:name, :email)
  end
end

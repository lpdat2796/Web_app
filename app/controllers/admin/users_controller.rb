# frozen_string_literal: true

class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[edit update]

  def index
    @user = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html do
          flash[:success] = 'User was successfully created.'
          redirect_to admin_root_url
        end
      else
        format.html { render :new }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html do
          flash[:success] = 'User was successfully updated.'
          redirect_to admin_root_url
        end
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    user = User.find_by(id: params[:id])
    if can? :destroy, user
      if user.delete
        respond_to do |format|
          format.html do
            flash[:success] = 'User was successfully deleted.'
            redirect_to admin_root_url
          end
        end
      else
        respond_to do |format|
          format.html do
            flash[:error] = 'User was failed to deleted.'
            redirect_to admin_root_url
          end
        end
      end
    else
      flash[:warning] = "You can't delete your own account."
      redirect_to admin_root_path
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end
end

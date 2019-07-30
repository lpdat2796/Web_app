class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:edit, :update]

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
        format.html { redirect_to admin_root_url, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_root_url, success: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def delete
    user = User.find_by(id: params[:id])
    if can? :destroy, user
      BooksUser.find_by(user_id: user.id).destroy if BooksUser.find_by(user_id: user.id).present?
      user.destroy
      respond_to do |format|
        format.html { redirect_to admin_root_url, success: 'User was successfully destroyed.' }
      end
    else
      flash[:warning] = "You can't delete your own account."
      redirect_to admin_root_path
    end
  end
  private

  def set_user
    @user = User.find_by(id: params[:id])
    byebug
  end
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :role)
  end
end

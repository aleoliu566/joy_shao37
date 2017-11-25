class Admin::UsersController < ApplicationController
  
  layout 'admin'
  
  def index
    @admin_users = User.is_admin
  end

  def create
  end

  def new
  end

  def remove_admin
    if User.set_admin(params[:email])
      redirect_to admin_users_path
    else
    end
  end

  def set_admin
    if User.find_by(email: params[:email])
      User.set_admin(params[:email])
      redirect_to admin_users_path
    else
      flash[:notice] = "無此使用者"
      redirect_to new_admin_user_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:role, :email)
  end
end

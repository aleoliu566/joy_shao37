class Admin::UsersController < ApplicationController
  
  layout 'admin'
  
  def index
    @admin_users = User.where(role:1)
    @users = User.all

  end

  def create
    
  end

  def new 

  end

  def update
    if User.find(params[:id]).update(user_params)
      redirect_to admin_users_path
    else
      render 'admin/users/index'
    end
  end

  def remove_admin
    if User.find(params[:id]).update(role:nil)
      redirect_to admin_users_path
    else
    end    
  end

  def set_admin
    if User.find(params[:user_id]).update(role:1)
      redirect_to admin_users_path
    else
    end
  end

  private
  def user_params
    params.require(:user).permit(:role)
  end
end

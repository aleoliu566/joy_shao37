class Admin::UsersController < ApplicationController
  
  layout 'admin'
  
  def index
    @admin_users = User.where(role:true)
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
    if User.find(params[:id]).update(role:false)
      redirect_to admin_users_path
    else
    end    
  end

  def set_admin
    if User.find_by(email: params[:email])
      User.find_by(email: params[:email]).update(role:true)
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

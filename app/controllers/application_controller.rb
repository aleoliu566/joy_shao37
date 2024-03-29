class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:birthday])
    devise_parameter_sanitizer.permit(:account_update, keys: [:birthday])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:gender])
    devise_parameter_sanitizer.permit(:account_update, keys: [:gender])
  end

  def authenticate_admin
    unless current_user.admin?
      flash[:alert] = "Not allow!"
      redirect_to root_path
    end
  end

end

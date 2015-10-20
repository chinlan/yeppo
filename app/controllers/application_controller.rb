class ApplicationController < ActionController::Base
   before_action :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def check_admin
    unless current_user.admin?
      #raise ActiveRecord::RecordNotFound
      redirect_to root_path
      return
    end
  end

  def configure_permitted_parameters
      devise_parameter_sanitizer.for(:account_update) << :username
      devise_parameter_sanitizer.for(:account_update) << :name
      devise_parameter_sanitizer.for(:account_update) << :location
      devise_parameter_sanitizer.for(:account_update) << :content

    end
end

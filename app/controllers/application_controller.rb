class ApplicationController < ActionController::Base
   before_action :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action  :set_contact_form
  

  protected

  def set_contact_form
    @contact = Contact.new
  end

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

  def after_sign_in_path_for(resource)
    sign_in_url = new_user_session_url
    if request.referer == sign_in_url
      super
    else
      stored_location_for(resource) || request.referer || root_path
    end
  end
end

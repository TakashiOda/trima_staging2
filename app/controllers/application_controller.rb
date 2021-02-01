class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  # Overwriting the sign_out redirect path method
  def after_sign_up_path_for(resource)
    binding.pry
    if resource == :user
      thank_you_for_registration_user_path
    elsif resource == :supplier
      thank_you_for_registration_supplier_path
    else
      thank_you_for_registration_user_path
    end
  end

  def after_sign_in_path_for(resource)
    if resource_name == :supplier
      supplier_dashboard_path(resource)
    elsif resource_name == :admin
      admin_path(resource)
    elsif resource_name == :user
      projects_path(resource)
    else
      root_path
    end
  end



  protected
  def configure_permitted_parameters
    added_attrs = [ :email, :name, :password, :password_confirmation ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end
end

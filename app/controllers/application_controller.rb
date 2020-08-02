class ApplicationController < ActionController::Base

  private

  # Overwriting the sign_out redirect path method
  def after_sign_up_path_for(resource)
    if resource == :user
      thank_you_for_registration_user_path
    elsif resource == :supplier
      thank_you_for_registration_supplier_path
    else
      thank_you_for_registration_user_path
    end
  end

  # def after_sign_in_path_for(resource_or_scope)
  #   if resource_or_scope == :user
  #     thank_you_for_registration_user_path
  #   elsif resource_or_scope == :supplier
  #     thank_you_for_registration_supplier_path
  #   else
  #     thank_you_for_registration_user_path
  #   end
  # end

  # def after_sign_out_path_for(resource_or_scope)
  #   if resource_or_scope == :user
  #     new_user_session_path
  #   elsif resource_or_scope == :supplier
  #     new_supplier_session_path
  #   else
  #     root_path
  #   end
  # end
end

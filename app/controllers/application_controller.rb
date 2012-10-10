class ApplicationController < ActionController::Base
  include BasicApplicationController
  protect_from_forgery
  helper_method :pl, :jt, :current_user

  rescue_from CanCan::AccessDenied do |exception|
    exception.default_message = alertify(:unauthorized_access)
    flash[:alert] = exception.message
    if current_user
      redirect_to welcome_url
    else
      session_original_url(request.path)
      redirect_to root_url
    end
  end
end

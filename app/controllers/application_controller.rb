class ApplicationController < ActionController::Base

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def require_user
    if !current_user
      flash[:login_alert] = "You must be logged in to do that."
      cookies[:return_to] = { value: request.path, expires: 120.seconds }
      redirect_to login_path
    end
  end

  def require_admin
    render file: "/public/404" unless current_admin?
  end
end

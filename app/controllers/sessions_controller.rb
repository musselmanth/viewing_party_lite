class SessionsController < ApplicationController

  def new
    @email = cookies[:email]
  end

  def create
    @email = params[:email]
    user = User.find_by(email: @email)
    if user && user.authenticate(params[:password])
      check_remember_me
      flash[:notice] = "Welcome #{user.name}!"
      session[:user_id] = user.id
      if user.admin?
        redirect_to admin_dashboard_path
      else
        redirect_to cookies.delete(:return_to) || dashboard_path
      end
    else
      @error = true
      render :login_form
    end
  end

  def destroy
    session.clear
    flash[:notice] = "You have been successfully logged out."
    redirect_to root_path
  end

  private

  def check_remember_me
    if params[:remember_me] == "1"
      cookies[:email] = { value: params[:email], expires: 180.days }
    elsif cookies[:email] == params[:email] && params[:remember_me] == "0"
      cookies.delete :email
    end
  end

end
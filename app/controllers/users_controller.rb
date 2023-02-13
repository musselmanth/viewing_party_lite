class UsersController < ApplicationController

  def new
    @new_user = User.new
  end

  def create
    @new_user = User.new(user_params)
    if @new_user.save
      session[:user_id] = @new_user.id
      flash[:notice] = "Welcome #{@new_user.name}!"
      redirect_to cookies.delete(:return_to) || dashboard_path
    else
      @errors = @new_user.errors
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
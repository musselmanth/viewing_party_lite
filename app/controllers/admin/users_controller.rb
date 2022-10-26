class Admin::UsersController < ApplicationController
  before_action :require_admin

  def show
    # mocks the view of the user dashboard but keeps admin user information in application layout
    render template: 'dashboard/show', locals: { current_user: User.find(params[:id]), admin_view: true }
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_dashboard_path
  end
end
class Admin::DashboardController < ApplicationController

  before_action :require_admin

  def show
    @users = User.all_except(current_user.id)
  end
end
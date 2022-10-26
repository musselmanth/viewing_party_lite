class ViewingPartiesController < ApplicationController

  before_action :require_user, :set_other_users

  def new
    @viewing_party = ViewingParty.new(host_id: current_user.id, movie_id: params[:movie_id])
  end

  def create   
    @viewing_party = ViewingParty.new(vp_params)
    if @viewing_party.save
      redirect_to dashboard_path
    else
      @errors = @viewing_party.errors
      render :new
    end
  end

  def destroy
    vp = ViewingParty.find(params[:id])
    user_id = vp.host_id
    vp.destroy if current_user == vp.host || current_user.admin?
    redirect_to current_user.admin? ? admin_user_path(user_id) : dashboard_path
  end

  private

  def vp_params
    params.require(:viewing_party).permit(
      :movie_id,
      :host_id,
      :duration,
      :date,
      :start_time,
      user_ids: []
    )
  end

  def set_other_users
    @other_users = User.all_except(current_user.id)
  end

end
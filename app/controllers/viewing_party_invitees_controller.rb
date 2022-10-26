class ViewingPartyInviteesController < ApplicationController
  def destroy
    vpi = ViewingPartyInvitee.find(params[:id])
    user_id = vpi.user_id
    vpi.destroy if vpi.user == current_user || current_user.admin?
    redirect_to current_user.admin? ? admin_user_path(user_id) : dashboard_path
  end
end
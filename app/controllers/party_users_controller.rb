class PartyUsersController < ApplicationController
  before_action :require_user
  def destroy
    party_user = PartyUser.where(party_id: params[:party_id], user_id: params[:user_id])[0]
    party_user.destroy
    redirect_to dashboard_path
  end
end

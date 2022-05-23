class PartyUsersController < ApplicationController
  
  def destroy
  	party_user = PartyUser.where(party_id: params[:party_id], user_id: params[:user_id])[0]
	  party_user.destroy  	
  	redirect_to user_path(params[:user_id])
  end
end
class FriendshipsController < ApplicationController
before_action :remember_me

  def create
  	user = User.find(params[:user_id])
  	friend = User.find_by(email: params[:email])
  	if !friend 
  		flash[:alert] = "Doesn't seem like your friend has an account yet, invite them to join Viewing Party!"
  	elsif friend.id == params[:user_id].to_i
  	  flash[:alert] = "You're already your best friend-no need to make it official!"
  	elsif user.friends.include?(friend)
  	  flash[:alert] = "#{friend.name} is already your friend-try a different email!"
  	else
  	  flash[:success] = "#{friend.name} is added as a friend. Invite them to your next Viewing Party!"
  	  Friendship.create(user_id: params[:user_id], friend_id: friend.id)
  	end  
  	  redirect_to "/users/#{params[:user_id]}"
  end

private 
  def remember_me
    if !cookies[:remember_me]
      redirect_to '/login'
      flash[:notice] = 'Your session has expired, please log in again!'
    end
  end
end
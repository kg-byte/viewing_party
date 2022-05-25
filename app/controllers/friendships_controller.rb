class FriendshipsController < ApplicationController
  include ControllerHelper
  before_action :require_user

  def create
    friend = User.find_by(email: params[:email])
    if !friend
      flash[:alert] = "Doesn't seem like your friend has an account yet, invite them to join Viewing Party!"
    elsif friend.id == current_user.id
      flash[:alert] = "You're already your best friend-no need to make it official!"
    elsif current_user.friends.include?(friend)
      flash[:alert] = "#{friend.name} is already your friend-try a different email!"
    else
      flash[:success] = "#{friend.name} is added as a friend. Invite them to your next Viewing Party!"
      Friendship.create(user_id: current_user.id, friend_id: friend.id)
    end
    redirect_to '/dashboard'
  end
end

class UsersController < ApplicationController
  include ControllerHelper
  before_action :set_user, :logged_in?, only: %i[show discover]

  def new; end

  def discover; end

  def show; end

  def create
    params = user_params
    params[:email] = user_params[:email].downcase
    user = User.create(params)
    if user.save
      session[:user_id]={value: user.id, expires: 1.week}
      redirect_to user_path(user) 
      flash[:success] = "Welcome, #{user.name}!"
    else
      redirect_to '/register'
      flash[:alert] = "#{user.errors.full_messages.to_sentence}"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

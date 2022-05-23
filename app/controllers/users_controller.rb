class UsersController < ApplicationController
  include ControllerHelper
  before_action :set_user, only: %i[show discover]
  before_action :remember_me, only: %i[show diescover]
  def index
    @users = User.all
  end

  def new; end

  def discover; end

  def show; end

  def create
    params = user_params
    params[:email] = user_params[:email].downcase
    user = User.create(params)
    if user.save
      cookies.encrypted[:remember_me]={value: 'hello', expires: 1.week}
      redirect_to user_path(user) 
      flash[:success] = "Welcome, #{user.name}!"
    else
      redirect_to '/register'
      flash[:alert] = "#{user.errors.full_messages.to_sentence}"
    end
  end

  def login
    user = User.find_by(email: params[:email])
    if !user || !user.authenticate(params[:password])
      flash[:error] = "Incorrect Credentials. Please try again!"
      render :login_form
    elsif user.authenticate(params[:password])
      cookies.encrypted[:remember_me]={value: 'hello', expires: 1.week}
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to user_path(user) 
    end
  end

  def logout
    cookies.delete :remember_me
    redirect_to root_path
    flash[:success] = "You have successfully logged out!"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

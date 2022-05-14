class UsersController < ApplicationController
  before_action :set_user, only: %i[update destroy show discover]

  def index
    @users = User.all
  end

  def new; end

  def discover; end

  def show; end

  def update; end

  def destroy; end

  def create
    params = user_params
    params[:email] = user_params[:email].downcase
    user = User.create(params)
    if user.save
      redirect_to user_path(user)
      flash[:success] = "Welcome, #{user.name}!"
    else
      redirect_to '/register'
      flash[:alert] = 'Error: please enter a name and unique email to register.'
    end
  end

  def login
    user = User.find_by(email: params[:email])
    if !user 
      flash[:error] = "u don goofed try again!"
      render :login_form
    end
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to user_path(user)
    else
      flash[:error] = "u don goofed try again!"
      render :login_form
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email,:password, :password_confirmation)
  end
end

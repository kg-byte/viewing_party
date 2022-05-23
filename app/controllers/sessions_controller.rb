class SessionsController < ApplicationController

  def create
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

  def destroy
    cookies.delete :remember_me
    redirect_to root_path
    flash[:success] = "You have successfully logged out!"
  end

end
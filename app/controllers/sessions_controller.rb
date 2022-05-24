class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email])   
    if user && user.authenticate(params[:password]) 
        cookies.encrypted[:remember_me]={value: 'hello', expires: 1.week}
        flash[:success] = "Welcome, #{user.name}!"
      if user.default?
        redirect_to user_path(user) 
      elsif user.admin?
        redirect_to '/admin/dashboard'
      end
    else
      flash[:error] = "Incorrect Credentials. Please try again!"
      render :login_form
    end
  end

  def destroy
    cookies.delete :remember_me
    redirect_to root_path
    flash[:success] = "You have successfully logged out!"
  end

end
class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email])   
    if user && user.authenticate(params[:password]) 
        session[:user_id]={value: user.id, expires: 1.week}
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
    session[:user_id] = nil 
    redirect_to '/login'
    flash[:success] = "You have successfully logged out!"
  end

end
# frozen_string_literal: true

class ApplicationController < ActionController::Base
  
  def current_user
  	@current_user ||= User.find_by(id: session[:user_id]["value"]) if session[:user_id]
  end

  def current_admin?
  	current_user && current_user.admin?
  end

  def require_user
     if !current_user 
       redirect_to '/login'
       flash[:success] = "Your session has expired, please log in again!"
     elsif current_admin?
       render file: "/public/404"
     end
  end
end

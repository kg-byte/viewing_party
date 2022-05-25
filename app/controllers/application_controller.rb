# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]['value']) if session[:user_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def require_user
    unless current_user
      redirect_to '/login'
      flash[:success] = 'Please log in to proceed!'
    end
  end

  def require_admin
    render file: '/public/404' unless current_admin?
    flash[:alert] = 'You do not have admin access.' unless current_admin?
  end
end

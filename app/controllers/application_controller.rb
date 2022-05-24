# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def current_user
  	@current_user ||= User.find(cookies[:remember_me]) if cookies[:remember_me]
  end
  def current_admin?
  	current_user && current_user.admin?
  end
end

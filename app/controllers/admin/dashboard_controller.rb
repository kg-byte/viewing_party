class Admin::DashboardController < ApplicationController

  def index
  	@users = User.where(role:0)
  	@parties = Party.all
  end

end
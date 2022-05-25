class Admin::DashboardController < ApplicationController
  before_action :require_admin
  def index
    @users = User.where(role: 0)
    @parties = Party.all
  end
end

class Admin::ViewingPartyController < ApplicationController
  before_action :require_admin

 

  def destroy
      Party.destroy(params[:id])
      flash[:notice] = 'You have successfully deleted the viewing party'
      redirect_to '/admin/dashboard'
  end

end

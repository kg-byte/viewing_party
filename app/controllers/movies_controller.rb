class MoviesController < ApplicationController
  before_action :set_user
  def index
    @movies = facade.top20 if params[:q] == 'top rated'
    if params[:keyword]
      @movies = facade.search(params[:keyword])
      @keyword = params[:keyword]
      if @movies.class == String
        redirect_to "/users/#{@user.id}/discover"
        flash[:alert] = "Error: #{@movies}, please try again!."
      end
    end
  end


  def facade
    @facade ||= MovieFacade.new
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end

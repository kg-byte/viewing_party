class MoviesController < ApplicationController
  before_action :set_user, :remember_me
  def index
    @movies = MovieFacade.top20 if params[:q] == 'top rated'
    if params[:keyword]
      @movies = MovieFacade.search(params[:keyword])
      @keyword = params[:keyword]
      if @movies.class != Array
        redirect_to "/users/#{@user.id}/discover"
        flash[:alert] = "Error: #{@movies}, please try again!"
      end
    # elsif params[:genre] == 'genre'
    #   @movies = MovieFacade.search_by_genre(params[:genre])
    #   @genre = params[:genre]
    end
  end

  def show
    @data = MovieFacade.movie_data(params[:id])
  end

  private
  def set_user
    @user = User.find(params[:user_id])
  end

  def remember_me
    if !cookies[:remember_me]
      redirect_to '/login'
      flash[:notice] = 'Your session has expired, please log in again!'
    end
  end
end

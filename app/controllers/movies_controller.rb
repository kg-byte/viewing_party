class MoviesController < ApplicationController
  include ControllerHelper
  def index
    @movies = MovieFacade.top20 if params[:q] == 'top rated'
    if params[:keyword]
      @movies = MovieFacade.search(params[:keyword])
      @keyword = params[:keyword]
      if @movies.class != Array
        redirect_to "/dashboard/discover"
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


end

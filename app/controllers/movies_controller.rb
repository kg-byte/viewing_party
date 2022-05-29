class MoviesController < ApplicationController
  include ControllerHelper
  before_action :set_page
  def index
    @data = MovieFacade.top_movies(@page) if params[:q] == 'top rated'
    if params[:keyword]
      @data = MovieFacade.search(params[:keyword], @page)
      if @data[:errors]
        redirect_to '/dashboard/discover'
        flash[:alert] = @data[:errors][0]
      else
        @data
      end
    end
  end

  def show
    @data = MovieFacade.movie_data(params[:id])
  end

  private 

  def set_page
    @page = (params[:page] || 1).to_i
  end
end

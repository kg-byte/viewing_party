class MovieFacade
  def self.top_movies(page)
    search = TmdbService.top_movies(page)
    total_results = search[:total_results]
    movies = search[:results].map {|movie_data| MovieDetail.new(movie_data)}
    {total_results: total_results, movies: movies}
  end

  def self.search(keyword, page)
    search = TmdbService.search(keyword, page)
    total_results = search[:total_results]
    movies = search[:results].map {|movie_data| MovieDetail.new(movie_data)}
    {total_results: total_results, movies: movies}

  end

  def self.movie_data(movie_id)
    data = {}
    data[:movie_details] = movie_details(movie_id)
    data[:movie_cast] = movie_cast(movie_id)
    data[:movie_reviews] = movie_reviews(movie_id)
    data
  end

  def self.movie_details(movie_id)
    MovieDetail.new(TmdbService.movie_details(movie_id))
  end

  def self.movie_cast(movie_id)
    TmdbService.movie_cast(movie_id)[:cast].map do |data|
      Cast.new(data)
    end
  end

  def self.movie_reviews(movie_id)
    TmdbService.movie_review(movie_id)[:results].map do |data|
      Review.new(data)
    end
  end
end

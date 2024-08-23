class MovieFacade

  def search_movies(query)
    data = SearchService.new(query)
    data.search_service.map do |movie_data|
      Movie.new(movie_data)
    end
  end

  def show_top_rated_movies 
    data = TopRatedService.new
    data.show_top_rated_movies.map do |movie_data|
      Movie.new(movie_data)
    end
  end

  def show_movie(id)
    data = ShowMovieService.new(id).show_exact_movie
    Movie.new(data)
  end
end
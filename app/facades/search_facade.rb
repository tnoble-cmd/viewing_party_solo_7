class SearchFacade
  
  def search_movies(query)
    data = SearchService.new(query)
    data.search_service.map do |movie_data|
      Movie.new(movie_data)
    end
  end
end
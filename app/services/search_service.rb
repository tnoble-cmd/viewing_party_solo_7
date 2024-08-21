class SearchService

  def initialize(query)
    @query = query
  end

  def search_service
    conn = Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
      faraday.headers['api_key'] = Rails.application.credentials.movie_db[:key]
    end

    response = conn.get("/3/search/movie?api_key=#{Rails.application.credentials.movie_db[:key]}&language=en-US&query=#{@query}&page=1&include_adult=false&language=en-US&page=1")

    JSON.parse(response.body, symbolize_names: true)[:results]
  end
end
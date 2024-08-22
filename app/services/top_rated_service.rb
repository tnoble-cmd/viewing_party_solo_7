class TopRatedService

  def show_top_rated_movies
    conn = Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
      faraday.headers['api_key'] = Rails.application.credentials.movie_db[:key]
    end

    response = conn.get("/3/movie/top_rated?api_key=#{Rails.application.credentials.movie_db[:key]}&language=en-US&page=1")

    data = JSON.parse(response.body, symbolize_names: true)[:results]
  end
end
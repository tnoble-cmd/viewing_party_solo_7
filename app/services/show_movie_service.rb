class ShowMovieService
  def initialize(movie_id)
    @movie_id = movie_id
  end

  def show_exact_movie
    conn = Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
      faraday.headers['api_key'] = Rails.application.credentials.movie_db[:key]
    end

    response = conn.get("/3/movie/#{@movie_id}?api_key=#{Rails.application.credentials.movie_db[:key]}&language=en-US")

    data = JSON.parse(response.body, symbolize_names: true)
  end

end
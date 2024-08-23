require 'rails_helper'

RSpec.describe ShowMovieService do

  before :each do
    @movie_id = 278
    stub_request(:get, "https://api.themoviedb.org/3/movie/#{@movie_id}?api_key=#{Rails.application.credentials.movie_db[:key]}&language=en-US").
      with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Api-Key'=>Rails.application.credentials.movie_db[:key],
          'User-Agent'=>'Faraday v2.10.1'
        }).
      to_return(status: 200, body: {
        "adult": false,
        "backdrop_path": "/avedvodAZUcwqevBfm8p4G2NziQ.jpg",
        "budget": 25000000,
        "genres": [
          {
            "id": 18,
            "name": "Drama"
          },
          {
            "id": 80,
            "name": "Crime"
          }
        ],
        "homepage": "",
        "id": 278,
        "imdb_id": "tt0111161",
        "origin_country": [
          "US"
        ],
        "original_language": "en",
        "original_title": "The Shawshank Redemption",
        "overview": "Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.",
        "popularity": 133.731,
        "poster_path": "/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg",
        "production_companies": [
          {
            "id": 97,
            "logo_path": "/7znWcbDd4PcJzJUlJxYqAlPPykp.png",
            "name": "Castle Rock Entertainment",
            "origin_country": "US"
          }
        ],
        "production_countries": [
          {
            "iso_3166_1": "US",
            "name": "United States of America"
          }
        ],
        "release_date": "1994-09-23",
        "revenue": 28341469,
        "runtime": 142,
        "spoken_languages": [
          {
            "english_name": "English",
            "iso_639_1": "en",
            "name": "English"
          }
        ],
        "status": "Released",
        "tagline": "Fear can hold you prisoner. Hope can set you free.",
        "title": "The Shawshank Redemption",
        "video": false,
        "vote_average": 8.705,
        "vote_count": 26667
      }.to_json, headers: { 'Content-Type' => 'application/json' })
  end

  it 'exists' do
    service = ShowMovieService.new(278)

    expect(service).to be_a(ShowMovieService)
  end

  it 'can return a movie' do
    service = ShowMovieService.new(278)
    movie = service.show_exact_movie

    expect(movie).to be_a(Hash)
    expect(movie).to have_key(:title)
    expect(movie).to have_key(:vote_average)
    expect(movie).to have_key(:runtime)
    expect(movie).to have_key(:genres)
    expect(movie).to have_key(:overview)
  end
end
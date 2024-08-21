require 'rails_helper'

RSpec.describe TopRated do
  before :each do
    stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{Rails.application.credentials.movie_db[:key]}&language=en-US&page=1").
      with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Api-Key'=>Rails.application.credentials.movie_db[:key],
          'User-Agent'=>'Faraday v2.10.1'
        }).
      to_return(status: 200, body: {
        results: [
          { title: 'Godzilla Minus One', vote_average: 7.583 },
          { title: 'Godzilla x Kong: The New Empire', vote_average: 7.182 }
        ]
      }.to_json, headers: { 'Content-Type' => 'application/json' })
  end

  it 'exists' do
    top_rated = TopRated.new

    expect(top_rated).to be_a(TopRated)
  end

  it '#show_top_rated_movies' do
    top_rated = TopRated.new
    results = top_rated.show_top_rated_movies

    expect(results).to be_an(Array)
    expect(results.first).to be_a(Movie)
    expect(results.first.title).to eq('Godzilla Minus One')
    expect(results.first.vote_average).to eq(7.583)
    expect(results.count).to eq(2)
  end
end

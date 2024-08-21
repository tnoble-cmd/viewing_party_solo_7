require 'rails_helper'

RSpec.describe SearchFacade do
  before do
    
    stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{Rails.application.credentials.movie_db[:key]}&language=en-US&query=Godzilla&page=1&include_adult=false").
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
    search_facade = SearchFacade.new

    expect(search_facade).to be_a(SearchFacade)
  end

  it 'can return an array of movie objects' do  
    search_facade = SearchFacade.new
    query = 'Godzilla'
    movies = search_facade.search_movies(query)

    expect(movies).to be_an(Array)
    expect(movies.first).to be_a(Movie)
  end
end
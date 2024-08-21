require 'rails_helper'

RSpec.describe SearchService do

  before :each do
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

  describe '#initialize' do
    it 'sets the query instance variable' do
      service = SearchService.new('Godzilla')
      expect(service.instance_variable_get(:@query)).to eq('Godzilla')
    end
end

  describe '#search_service' do
    it 'returns parsed JSON response' do
      service = SearchService.new('Godzilla')
      results = service.search_service

      expect(results).to be_an(Array)
      expect(results.first[:title]).to eq('Godzilla Minus One')
      expect(results.first[:vote_average]).to eq(7.583)
    end
  end
end
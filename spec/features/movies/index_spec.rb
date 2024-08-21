require 'rails_helper'

RSpec.describe 'Movies Index Page' do
  before :each do
    @user = User.create!(name: 'Tommy', email: 'tommyguy@gmail.com')
  end

  it 'can display top rated movies' do
    # Stubbing the request for top results
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
          { title: 'Creation of the Gods I: Kingdom of Storms', vote_average: 7.109 },
          { title: 'Godzilla x Kong: The New Empire', vote_average: 7.182 }
        ]
      }.to_json, headers: { 'Content-Type' => 'application/json' })

    #visit discover page first
    visit discover_user_path(@user)

    within "#discover-button" do
      click_button 'Discover Top Rated Movies'
    end

    expect(current_path).to eq(user_movies_path(@user))

    expect(page).to have_content('Movies Results Page')

    expect(page).to have_content('Godzilla Minus One')
    expect(page).to have_content('Creation of the Gods I: Kingdom of Storms')
    expect(page).to have_content('Godzilla x Kong: The New Empire')

    expect(page).to have_content('Vote Average: 7.583')
    expect(page).to have_content('Vote Average: 7.109')
    expect(page).to have_content('Vote Average: 7.182')

    expect(page).to have_css('#movie', count: 3)
  end

  it 'can display search results and has a return to discover page button' do

    # Stubbing the request for search results
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

    #visit discover page first
    visit discover_user_path(@user)

    within "#search-field" do
      fill_in :query, with: 'Godzilla'
      click_button 'Search'
    end

    expect(current_path).to eq(user_movies_path(@user))

    expect(page).to have_content('Movies Results Page')

    expect(page).to have_content('Godzilla Minus One')
    expect(page).to have_content('Godzilla x Kong: The New Empire')

    expect(page).to have_content('Vote Average: 7.583')
    expect(page).to have_content('Vote Average: 7.182')

    expect(page).to have_css('#movie', count: 2)

    # Has a return to discover page button
    within "#discover-button" do
      click_button 'Discover Page'
    end

    expect(current_path).to eq(discover_user_path(@user))
  end
end
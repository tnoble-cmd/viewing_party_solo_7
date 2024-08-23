require 'rails_helper'

RSpec.describe 'Movie Show Page' do
  before :each do
    @user = User.create!(name: 'Tommy', email: 'tommy123@gmail.com')
    @movie_id = 278

    stub_request(:get, "https://api.themoviedb.org/3/movie/#{@movie_id}?api_key=7d1bc6db0f76dbcea0f1521eac25ce87&language=en-US")
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Api-Key' => '7d1bc6db0f76dbcea0f1521eac25ce87',
          'User-Agent' => 'Faraday v2.10.1'
        }
      )
      .to_return(status: 200, body: {
        title: 'The Shawshank Redemption',
        vote_average: 8.7,
        runtime: 142,
        genres: [{ name: 'Drama' }, { name: 'Crime' }],
        overview: 'Fear can hold you prisoner. Hope can set you free.'
      }.to_json, headers: { 'Content-Type' => 'application/json' })
  end

  it 'shows movie details' do
    visit user_movie_path(user_id: @user.id, id: @movie_id)

    within '#movie-section' do
      expect(page).to have_content('The Shawshank Redemption')
      expect(page).to have_content('Fear can hold you prisoner. Hope can set you free.')
      expect(page).to have_content('8.7')
      expect(page).to have_content('2h 22m')
      expect(page).to have_content('Drama')
      expect(page).to have_content('Crime')
    end
  end

  it 'has a button to the Discover page' do
    visit user_movie_path(user_id: @user.id, id: @movie_id)

    within '#button-section' do
      click_button 'Discover Page'
    end

    expect(current_path).to eq(discover_user_path(@user))
  end
end

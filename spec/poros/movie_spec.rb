require 'rails_helper'

RSpec.describe Movie do 

  it 'exists' do 
    movie = Movie.new({
      title: 'Godzilla Minus One',
      vote_average: 7.583
    })

    expect(movie).to be_a(Movie)
  end

  it 'has attributes' do 
    movie = Movie.new({
      title: 'Godzilla Minus One',
      vote_average: 7.583
    })

    expect(movie.title).to eq('Godzilla Minus One')
    expect(movie.vote_average).to eq(7.583)
  end
end
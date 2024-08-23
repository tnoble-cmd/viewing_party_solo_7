require 'rails_helper'

RSpec.describe Movie do 

  it 'exists' do 
    movie = Movie.new({
      title: 'Godzilla Minus One',
      vote_average: 7.583,
      runtime: 120,
      genres: [{ name: 'Action' }, { name: 'Adventure' }],
      overview: 'Godzilla is missing'
    })

    expect(movie).to be_a(Movie)
  end

  it 'has attributes' do 
    movie = Movie.new({
      title: 'Godzilla Minus One',
      vote_average: 7.583,
      runtime: 120,
      genres: [{ name: 'Action' }, { name: 'Adventure' }],
      overview: 'Godzilla is missing'
    })

    expect(movie.title).to eq('Godzilla Minus One')
    expect(movie.vote_average).to eq(7.583)
    expect(movie.runtime).to eq(120)
    expect(movie.genres).to eq([{ name: 'Action' }, { name: 'Adventure' }])
    expect(movie.overview).to eq('Godzilla is missing')
  end

  it 'can convert runtime to hours and minutes' do 
    movie = Movie.new({
      title: 'Godzilla Minus One',
      vote_average: 7.583,
      runtime: 120,
      genres: [{ name: 'Action' }, { name: 'Adventure' }],
      overview: 'Godzilla is missing'
    })

    expect(movie.runtime_in_hours_and_minutes).to eq('2h 0m')
  end
end
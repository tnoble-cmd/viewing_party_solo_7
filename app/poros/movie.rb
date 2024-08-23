class Movie
  attr_reader :title, 
              :vote_average,
              :runtime, 
              :genres, 
              :overview
  def initialize(data)
    @title = data[:title]
    @vote_average = data[:vote_average]
    @runtime = data[:runtime]
    @genres = data[:genres]
    @overview = data[:overview]
  end

  def runtime_in_hours_and_minutes
    hours = @runtime / 60
    minutes = @runtime % 60
    "#{hours}h #{minutes}m"
  end
end


class MoviesController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    search_facade = MovieFacade.new
    top_rated = MovieFacade.new
    

    if params[:query].present?
      @movies = search_facade.search_movies(params[:query])
    else
      @movies = top_rated.show_top_rated_movies
    end
  end
end

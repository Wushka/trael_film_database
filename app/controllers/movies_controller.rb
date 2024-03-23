class MoviesController < ApplicationController
  def index()
    @movies = Movie.all.preload(:posters)
  end

  def show()
    @movie = Movie.preload(:actors, :genres, :posters).find(params[:id])
  end

  def destroy()
    Movie.find(params[:id]).destroy
    redirect_to movies_path
  end

  def edit()
    @movie = Movie.preload(:actors, :genres, :posters).find(params[:id])
  end

  def update()
    movie = Movie.find(params[:id])
    params.permit!
    movie.update(params[:movie])
    redirect_to movie_path(movie)
  end

  def new()
    @query = params["query"]
    unless @query.blank?
      api_result = Omdb::Api.search_movies(@query)
      @search_results = api_result["Search"]
    end
  end

  def create()
    movie_json = Omdb::Api.movie_details(params["imdb_id"])
    Movie.create_from_omdb_json(movie_json)
    redirect_to movies_path
  end

  def add_poster()
    movie = Movie.find(params[:movie_id])
    if !params["poster_url"].blank? && is_valid_url?(params["poster_url"])
      movie.add_poster(params["poster_url"])
    end
    redirect_to edit_movie_path(movie)
  end

  private def is_valid_url?(str)
    uri = URI.parse(str)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
    rescue URI::InvalidURIError
    false
  end
end

class MovieGenresController < ApplicationController
  def destroy()
    movie_genre = MovieGenre.find(params[:id])
    movie_id = movie_genre.movie_id
    movie_genre.destroy
    redirect_to edit_movie_path(id: movie_id)
  end
end

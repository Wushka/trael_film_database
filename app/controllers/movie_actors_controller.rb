class MovieActorsController < ApplicationController
  def destroy()
    movie_actor = MovieActor.find(params[:id])
    movie_id = movie_actor.movie_id
    movie_actor.destroy
    redirect_to edit_movie_path(id: movie_id)
  end
end

class PostersController < ApplicationController
  def destroy()
    poster = Poster.find(params[:id])
    movie_id = poster.movie_id
    poster.destroy
    redirect_to edit_movie_path(id: movie_id)
  end
end

class Actor < ApplicationRecord
  has_many :movie_actors
  has_many :movies, through: :movie_actors

  def add_movie(movie)
      MovieActor.create(movie_id: movie.id, actor_id: self.id)
  end
end

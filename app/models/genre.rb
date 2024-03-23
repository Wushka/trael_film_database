class Genre < ApplicationRecord
  has_many :movie_genres
  has_many :movies, through: :movie_genres

  def add_movie(movie)
      MovieGenre.create(movie_id: movie.id, genre_id: self.id)
  end
end

class Movie < ApplicationRecord
  has_many :movie_actors
  has_many :movie_genres
  has_many :actors, through: :movie_actors
  has_many :genres, through: :movie_genres
  has_many :posters

  def add_actor(actor)
    MovieActor.create(movie_id: self.id, actor_id: actor.id)
  end

  def add_actors(actors)
    actors.split(", ").each do |actor_name|
      actor = Actor.find_or_create_by(name: actor_name)
      add_actor(actor)
    end
  end

  def add_genre(genre)
    MovieGenre.create(movie_id: self.id, genre_id: genre.id)
  end

  def add_genres(genres)
    genres.split(", ").each do |genre_name|
      genre = Genre.find_or_create_by(name: genre_name)
      add_genre(genre)
    end
  end

  def add_poster(url)
    Poster.create(movie_id: self.id, url: url)
  end

  def poster_urls()
    if posters.any?
      posters.order(:created_at).map{|p| p.url}
    else
      ["https://static.thenounproject.com/png/1077596-200.png"]
    end
  end

  def self.create_from_omdb_json(omdb_json)
      movie = Movie.create(
        title: omdb_json["Title"],
        genre_id: omdb_json["Title"],
        plot: omdb_json["Plot"],
        release_date: DateTime.parse(omdb_json["Released"])
      )

      movie.add_actors(omdb_json["Actors"])
pp omdb_json["Genre"]
      movie.add_genres(omdb_json["Genre"])

      movie.add_poster(omdb_json["Poster"]) unless omdb_json["Poster"].blank?
    end
end

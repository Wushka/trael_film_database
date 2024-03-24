require "test_helper"

class MovieTest < ActiveSupport::TestCase
  test "correctly creates a movie from omdb api response" do
    api_response = Omdb::Api.movie_details("tt0385700")

    initial_movie_count = Movie.count
    new_movie = Movie.create_from_omdb_json(api_response)

    assert Movie.count == initial_movie_count + 1

    assert Movie.where(id: new_movie.id).any?

    assert Movie.find(new_movie.id) == new_movie

    assert new_movie.plot == api_response["Plot"]
    assert new_movie.title == api_response["Title"]

    movie_genres_string = new_movie.genres.map(&:name).join(", ")
    assert movie_genres_string == api_response["Genre"]

    movie_actors_string = new_movie.actors.map(&:name).join(", ")
    assert movie_actors_string == api_response["Actors"]

    first_poster = new_movie.posters.order(:created_at).first
    assert first_poster.url == api_response["Poster"]
  end

  test "correctly adds an actor to a movie" do
    movie = Movie.first

    assert movie.actors.empty?
    movie.add_actors("Bruce Willis")

    movie.reload
    assert movie.actors.count == 1
  end

  test "doesn't create the same actor twice" do
    movie = Movie.first

    initial_actor_count = Actor.count
    assert movie.actors.empty?
    movie.add_actors("Bruce Willis, Megan Fox")

    assert Actor.count == initial_actor_count + 2

    movie.add_actors("Bruce Willis, Megan Fox")

    assert Actor.count == initial_actor_count + 2

    assert movie.actors.count == 2
  end

  test "correctly adds a genre to a movie" do
    movie = Movie.first

    assert movie.genres.empty?
    movie.add_genres("Horror")

    movie.reload
    assert movie.genres.count == 1
  end

  test "doesn't create the same actgenreor twice" do
    movie = Movie.first

    initial_genre_count = Genre.count
    assert movie.genres.empty?
    movie.add_genres("Horror, Comedy")

    assert Genre.count == initial_genre_count + 2

    movie.add_genres("Horror, Comedy")

    assert Genre.count == initial_genre_count + 2

    assert movie.genres.count == 2
  end
end

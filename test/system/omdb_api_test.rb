require "test_helper"

class OmbdApiTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "gets failure response on bad request" do
    res = Omdb::Api.get()

    assert res["Response"] == "False"
  end

  test "gets full search result" do
    max_search_results_per_page = 10
    res = Omdb::Api.search_movies("final")

    assert res["Response"] == "True"
    assert res["Search"].count == max_search_results_per_page
  end

  test "gets movie details from imdb_id" do
    res = Omdb::Api.movie_details("tt0195714")

    assert res["Response"] == "True"
    assert res["Title"] == "Final Destination"
  end
end

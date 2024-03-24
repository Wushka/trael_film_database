require "application_system_test_case"

class MoviesControllerTest < ApplicationSystemTestCase
  driven_by :selenium, using: :headless_chrome

  setup do
    10.times do |i|
      m = Movie.create({title: "Title#{i}", plot: "Plot#{i}"})
    end
  end

  test "shows movies list" do
    visit movies_path
    assert_selector "h1", text: "Favorit Film"
  end

  test "shows all movies" do
    visit movies_path
    assert_selector "div#movies_list" do
      assert_selector "div.movie", count: Movie.count
    end
  end

  test "deletes a movie when clicked" do
    visit movies_path
    initial_movie_count = Movie.count

    accept_confirm do
      assert_selector "div#movies_list" do
        assert_selector "div.movie" do |movie_div|
          within(movie_div) do
              click_link "Fjern fra liste"
          end
        end
      end
    end
    sleep 0.5
    assert Movie.count == initial_movie_count - 1
  end

  test "shows search results" do
    api_max_results = 10
    visit new_movie_path({query: "final"})
    find "div#search_results" do |search_results|
      assert search_results.all("form").count == api_max_results
    end
  end

  test "creates movie from search result" do
    initial_movie_count = Movie.count

    visit new_movie_path({query: "final"})
    find "div#search_results" do |search_results|
      search_results.first("form") do |search_result|
        within(search_result) do
          click_on "Tilføj Til Liste"
        end
      end
    end
    sleep 0.5
    assert Movie.count == initial_movie_count + 1
  end
end

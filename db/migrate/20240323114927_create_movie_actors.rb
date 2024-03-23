class CreateMovieActors < ActiveRecord::Migration[7.1]
  def change
    create_table :movie_actors do |t|
      t.integer  :movie_id
      t.integer  :actor_id
    end
  end
end

class CreatePosters < ActiveRecord::Migration[7.1]
  def change
    create_table :posters do |t|
      t.string    :url
      t.integer   :movie_id
      t.timestamps
    end
  end
end

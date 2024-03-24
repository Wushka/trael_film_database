class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string  :title
      t.string  :plot
      t.string  :release_year
      t.timestamps
    end
  end
end

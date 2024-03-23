class ChangeReleaseYearOnMovie < ActiveRecord::Migration[7.1]
  def change
    remove_column :movies, :release_year
    add_column :movies, :release_date, :datetime
  end
end

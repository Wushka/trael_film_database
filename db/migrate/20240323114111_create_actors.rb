class CreateActors < ActiveRecord::Migration[7.1]
  def change
    create_table :actors do |t|
      t.string  :name
      t.string  :biography
      t.integer :year_of_birth
      t.timestamps
    end
  end
end

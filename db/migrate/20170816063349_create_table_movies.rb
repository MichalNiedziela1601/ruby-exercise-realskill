class CreateTableMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.string :year
      t.integer :runtime
      t.string :rate
      t.integer :votes_count
    end
  end
end

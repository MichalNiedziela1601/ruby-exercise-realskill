class CreateGenresMoviesJoinTable < ActiveRecord::Migration
  def change
    create_join_table :genres, :movies do |t|
      t.index :genres_id
      t.index :movies_id
    end
  end
end

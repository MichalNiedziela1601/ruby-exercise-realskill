class CreateActorsMoviesJoinTable < ActiveRecord::Migration
  def change
    create_join_table :actors, :movies do |t|
      t.index :actors_id
      t.index :movies_id
    end
  end
end

class AddConstraintsAndIndexes < ActiveRecord::Migration[7.1]
  def change
    # Movies
    change_column_null :movies, :title, false
    change_column_null :movies, :overview, false
    add_index :movies, :title, unique: true

    # Lists
    change_column_null :lists, :name, false
    add_index :lists, :name, unique: true

    # Bookmarks
    change_column_null :bookmarks, :comment, false
    change_column_null :bookmarks, :movie_id, false
    change_column_null :bookmarks, :list_id, false
    add_index :bookmarks, [:movie_id, :list_id], unique: true
  end
end

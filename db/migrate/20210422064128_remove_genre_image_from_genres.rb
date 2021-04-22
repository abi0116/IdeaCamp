class RemoveGenreImageFromGenres < ActiveRecord::Migration[5.2]
  def change
    remove_column :genres, :genre_image, :string
  end
end

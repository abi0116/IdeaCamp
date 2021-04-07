class Admins::GenresController < ApplicationController

  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    genre = Genre.new(genre_params)
    genre.save
    redirect_back(fallback_location: root_path)
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admins_genres_path
    else
      render :edit
    end
  end

  def destroy
    @genre = Genre.find(params[id])
    @genre.destroy
    redirect_to admins_genres_path
  end

end

class MoviesController < ApplicationController

  def index
    movies = Movie.all
    render json: movies, root: "movies", each_serializer: MovieSerializer,
        meta: { count: movies.count}, adapter: :json
  end

  def show
    movie = Movie.find(params[:id])
    render json: movie, root: "movie", serializer: MovieSerializer, adapter: :json
  end

end

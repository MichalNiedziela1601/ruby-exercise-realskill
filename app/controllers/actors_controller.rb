class ActorsController < ApplicationController

  def index
    actors = Actor.all
    render json: actors, root: "actors", each_serialize: ActorSerializer,
           meta: {count: actors.count}, adapter: :json
  end

  def show
    actor = Actor.find(params[:id])
    render json: actor, root: "actor", serializer: ActorSerializer, adapter: :json

  end

  def update
    actor = Actor.find(params[:id])
    if actor.update_attributes(params_attribute)
      render json: actor, root: "actor", serializer: ActorSerializer, adapter: :json, status: :ok
    else
      respond_with_errors(actor)
    end
  end

  def create
    actor = Actor.new(params_attribute)
    if actor.save
      render json: actor, root: "actor", serializer: ActorSerializer, adapter: :json, status: :created
    else
      respond_with_errors(actor)
    end
  end

  def rate
    actor = Actor.find(params[:id])
    if ("0.0".."10.0").to_a.include?(vote_params)
      new_vote = vote_params.to_f
      current_votes_count = actor.votes_count
      current_rate = actor.rate
      new_rate = ((current_rate.to_f * current_votes_count)+new_vote)/(current_votes_count + 1)
      new_rate = new_rate.round(1).to_s
      actor.update_attributes(rate: new_rate, votes_count: current_votes_count + 1)
      render json: actor, root: "actor", serializer: ActorSerializer, adapter: :json
    else
      actor.errors[:rate] << "Rate should be between 0.0 to 10.0"
      respond_with_errors(actor)
    end

  end

  private

  def params_attribute
    params.require(:actor).permit(:name, :date_of_birth)
  end

  def vote_params
    params.require(:actor).require(:vote)
  end
end

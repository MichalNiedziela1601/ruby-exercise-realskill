class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :runtime, :year, :rate, :votes_count
end
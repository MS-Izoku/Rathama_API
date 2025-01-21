# frozen_string_literal: true

class PlayerClassSerializerLite < Oj::Serializer
  attributes :name, :id
end

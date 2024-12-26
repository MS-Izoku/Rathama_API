# frozen_string_literal: true

class PlayerClassSerializer < Oj::Serializer
  attributes :name, :description, :id
end

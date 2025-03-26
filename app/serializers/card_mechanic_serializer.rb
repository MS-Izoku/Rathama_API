# frozen_string_literal: true

class CardMechanicSerializer < Oj::Serializer
  attributes :name, :description, :args, :is_trait
end

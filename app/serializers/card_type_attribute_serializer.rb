# frozen_string_literal: true

class CardTypeAttributeSerializer < Oj::Serializer
  attributes id:, :name, :description
end

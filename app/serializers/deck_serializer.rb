# frozen_string_literal: true

class DeckSerializer < Oj::Serializer
  attributes :id, :name, :description, :created_at, :updated_at, :deck_code, :generation_status, :is_playable,
             :playability_status
end

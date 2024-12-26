# frozen_string_literal: true

class CardSerializer < Oj::Serializer
  attributes :name, :cost, :card_text, :flavor_text, :rarity, :expansion_id
end

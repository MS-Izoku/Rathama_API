# frozen_string_literal: true

class HeroIndexSerializer < Oj::Serializer
  object_as :card
  attributes :id, :name, :card_text

  attribute :scale_powers do
    ScalePowerMicroSerializer.many(card.scale_powers.to_a)
  end

  attribute :player_classes do
    PlayerClassSerializer.many(card.player_classes)
  end
end
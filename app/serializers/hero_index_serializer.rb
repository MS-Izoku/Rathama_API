# frozen_string_literal: true

class HeroIndexSerializer < Oj::Serializer
  object_as :card
  # known bug: art_url is null but full_card_url is populated (for seeded cards)
  attributes :id, :name, :card_text, :art_url

  attribute :scale_powers do
    sp = ScalePower.where(hero_card_id: card.id)
    ScalePowerMicroSerializer.many(sp)
  end
end

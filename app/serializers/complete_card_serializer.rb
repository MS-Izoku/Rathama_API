# frozen_string_literal: true

class CompleteCardSerializer < Oj::Serializer
  # Make the internal object name explicit for clarity in blocks
  object_as :card

  # Scalar attributes that come directly from the card
  attributes :id,
             :name,
             :card_text,
             :cost,
             :flavor_text,
             :rarity,
             :type,
             :attack,
             :health,
             :armor,
             :durability,
             :expansion_id,
             :created_at,
             :updated_at,
             :is_generated_card,
             :deck_size_modifier_type,
             :deck_size_modifier_value,
             :art_url,
             :full_card_url

  # Explicit nested serialization (self-contained)
  attribute :expansion do
    card.expansion && ExpansionMicroSerializer.one(card.expansion)
  end

  attribute :card_mechanic_assignments do
    CardMechanicAssignmentSerializer.many(card.card_mechanic_assignments.to_a)
  end

  attribute :player_classes do
    PlayerClassMicroSerializer.many(card.player_classes.to_a)
  end

  attribute :card_type_attributes do
    CardTypeAttributeMicroSerializer.many(card.card_type_attributes.to_a)
  end
end

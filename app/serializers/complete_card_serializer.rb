# frozen_string_literal: true

class CompleteCardSerializer < Oj::Serializer
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
             :full_card_url  # ← New attributes

  belongs_to :expansion, serializer: ExpansionMicroSerializer
  has_many :card_mechanic_assignments, serializer: CardMechanicAssignmentSerializer
  has_many :player_classes, serializer: PlayerClassMicroSerializer
  has_many :card_type_attributes, serializer: CardTypeAttributeMicroSerializer
end

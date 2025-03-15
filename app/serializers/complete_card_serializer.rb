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
             :deck_size_modifier_value

  # Include expansion details
  belongs_to :expansion, serializer: ExpansionSerializer

  # Include effects as an array of hashes
  has_many :card_mechanic_assignments, serializer: CardMechanicAssignmentSerializer
end

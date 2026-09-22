# frozen_string_literal: true

class PlayerClassCard < ApplicationRecord
  belongs_to :player_class
  belongs_to :card

  validate :validate_uniqueness

  private

  def validate_uniqueness
    matches = PlayerClassCard.where(player_class_id:, card_id:)
    return if matches.empty? || matches.first.id == id

    errors.add(:base, 'This card is already associated with this player class.')
  end
end

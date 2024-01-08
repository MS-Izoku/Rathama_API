class DeckCard < ApplicationRecord
    belongs_to :deck
    belongs_to :card

    validate :validate_deck_card_count

private
    def self.deck_limits_per_card_rarity
        {
            "Common": 2,
            "Uncommon": 2,
            "Rare": 2,
            "Epic": 2,
            "Legendary": 1,
            "Artifact": 1
        }
    end

    def validate_deck_card_count
        if deck.present? && card.present?
            card_count = deck.deck_cards.where(card: card).count
            max_card_count = DeckCard.deck_limits_per_card_rarity[card.rarity]

            if card_count > max_card_count
                errors.add(:base, "Deck already has the maximum number of allowed #{card.name} Cards (#{max_card_count})")
            end
        end
    end
end

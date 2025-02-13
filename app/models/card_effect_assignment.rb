class CardEffectAssignment < ApplicationRecord
    belongs_to :card
    belongs_to :card_effect
end

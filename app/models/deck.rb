class Deck < ApplicationRecord
    has_many :deck_cards
    has_many :cards, through: :deck_cards
    
    def deck_code
    end

    def self.generate_deck_code
    end
end

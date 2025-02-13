class CardEffect < ApplicationRecord
    validates :format, presence: true
    validates :name, uniqueness: true

    # this creates the card-effect syntax used when creating a card
    # ex: Raid(3) comes from "Raid::(quantity:integer)" where the quantity is 3
    def self.create_card_effect
        # remove whitespace and use the expected format
        "#{self.name.titleize.gsub(/\s+/, "")}::(#{self.format})"
    end
end

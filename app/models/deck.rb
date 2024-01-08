class Deck < ApplicationRecord
    has_many :deck_cards
    has_many :cards, through: :deck_cards

    # parse an existing deck code and return the Deck object
    def self.parse_deck_code(deck_code)
        # Base64 decode the deck code
        decoded_string = Base64.strict_decode64(deck_code)

        # Split the decoded string into name, class, and card string
        name, class_name, card_string = decoded_string.split(',')
        # binding.break # debug here

        # Split the card string into individual card representations
        card_array = card_string.split(',').map do |card|
        card_info = card.split(':')
        { id: card_info[0], count: card_info[1].to_i }
        end


        # Create a new Deck object
        Deck.new(name, class_name)
    end


    # generate a Base64 Deck Code out of the asscociated Cards in the deck
    def generate_deck_code
        # Combine card IDs and counts into a string
        card_string = @cards.map { |card| "#{card[:id]}:#{card[:count]}" }.join(',')
        
        player_class_identifier = "[Class Identifier]"
        # Construct the deck string: [Name],[Class],[CardString]
        deck_string = "#{name},#{player_class_identifier},#{card_string}"

        # Base64 encode the deck string
        deck_code = Base64.strict_encode64(deck_string)
    end
end

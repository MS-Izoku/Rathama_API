class Deck < ApplicationRecord
  has_many :deck_cards
  has_many :cards, through: :deck_cards
  belongs_to :user, class: "User", foreign_key: "owner_id"

  # parse an existing deck code and return the Deck object
  def self.parse_deck_code(deck_code)
    # Base64 decode the deck code
    decoded_string = Base64.strict_decode64(deck_code)

    # Split the decoded string into name, class, and card string
    name, class_name, card_string = decoded_string.split(',')

    # Split the card string into individual card representations
    card_array = card_string.split(',').map do |card|
      card_info = card.split(':')
      { id: card_info[0], count: card_info[1].to_i }
    end

    # Create a new Deck object
    deck = new(name, class_name)
    deck.instance_variable_set(:@cards, card_array) # Set the private instance variable @cards
    deck
  end


  # generate a Base64 Deck Code out of the associated Cards in the deck
  def generate_deck_code
    # Combine card IDs and counts into a string
    card_string = cards.map { |card| "#{card[:id]}:#{card[:count]}" }.join(',')

    player_class_identifier = '[Class Identifier]'
    # Construct the deck string: [Name],[Class],[CardString]
    deck_string = "#{name},#{player_class_identifier},#{card_string}"

    # Base64 encode the deck string
    Base64.strict_encode64(deck_string)
  end



  # Validate the Deck Code against all generation methods
  def validate_deck_code
    validate_checksum # Call validate_checksum internally
  end


  private

# region Checksum Validation for Deck Codes
  def validate_checksum
    calculate_checksum == extract_checksum
  end

  def calculate_checksum
    # Combine relevant deck information into a string for checksum calculation
    checksum_string = "#{name},#{player_class_identifier},#{cards.map do |card|
        "#{card[:id]}:#{card[:count]}"
    end

    checksum_string = checksum_string.join(',')}"

    # Calculate the CRC32 checksum
    Zlib.crc32(checksum_string)
  end

  def extract_checksum
    # Extract checksum from the decoded deck code
    decoded_string = Base64.strict_decode64(@deck_code)
    _, _, _, checksum = decoded_string.split(',')
    checksum.to_i
  end
# endregion

end

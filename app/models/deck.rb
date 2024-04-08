require 'json'
require 'base64'
class Deck < ApplicationRecord
  has_many :deck_cards
  has_many :cards, through: :deck_cards
  belongs_to :user, class_name: 'User', foreign_key: 'owner_id'

  before_save :validate_deck_card_count
  before_save :modify_deck_code

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

    deck_json = {
      name:,
      class_name:,
      cards: card_array
    }

    # Return the JSON representation
    JSON.generate(deck_json)
  end


  # Initialized => Ready to Add Cards, but not ready for gameplay
  # GameReady => Correct number of cards and initialized
  # NotReady => Incorrect number of cards or other errors, but already initialized
  def generation_status_values
    [ 'Initialized', 'GameReady' , 'NotReady']
  end

  # generate a Base64 Deck Code out of the associated Cards in the deck
  def generate_deck_code(debug = false)
    # Combine card IDs and counts into a string
    card_string = cards.map { |card| "#{card[:id]}-#{card[:count]}" }.join(',')
    card_string = "[#{card_string}]"

    puts "[]===>> CardString::#{card_string}" if debug

    player_class_identifier = '[Class Identifier]'
    # Construct the deck string: [Name],[Class],[CardString]
    deck_string = "#{name},#{player_class_identifier},#{card_string}"

    # Base64 encode the deck string
    full_code = Base64.strict_encode64(deck_string)

    puts "Parsed Code:\n#{Deck.parse_deck_code(full_code)}" if debug

    full_code
  end

  # Validate the Deck Code against all generation methods
  def validate_deck_code
    validate_checksum # Call validate_checksum internally
  end

  # a method to create a deck and cards using a single transaction
  def self.create_deck_from_params(input_params)

    card_list = input_params[:card_ids]
    deck = Deck.new(input_params.except(:card_ids))
    deck.generation_status = 'Initialized'

    deck.save!

    # create the DeckCards using the provided list of Ids
    Deck.create_deck_cards(deck, card_list)

    deck.generation_status = 'GameReady'
    deck.save

    deck
  end


  # update the card list of a given Deck
  def self.update_card_list(input_params)
    card_list = input_params[:card_ids] # this is an array/list of integers

    # get information regarding current deck_cards
    deck_card_ids = deck_cards.pluck(:id) # ids of the DeckCards of this Deck
    current_card_ids = deck_cards.pluck(:card_id) # ids of the cards themselves
    
    # get lists of cards to add and remove based on their ids
    deck_cards_to_add = []
    deck_cards_to_destroy = []

    # destroy the deck_cards not found in the cards list
    # create deck_cards found in the list

    # Find cards to add and remove
    cards_to_add = card_list - current_card_ids
    cards_to_remove = current_card_ids - card_list

    # Destroy DeckCards for cards to remove
    deck.deck_cards.where(card_id: cards_to_remove).destroy_all

    Deck.create_deck_cards(@deck, cards_to_add)

    # create the DeckCards using the provided list of Ids
    Deck.create_deck_cards(deck, card_list)
    if deck.errors.any?
      p "Errors creating Deck List"
      p deck.errors
    else
      p "No Errors creating Deck List"
    end
    deck
  end

  # a method to create and destroy Deck Cards for a given deck
  # can also be used using a partial-list during Update instead of a full list during create
  def self.create_deck_cards(deck, card_ids)
    return unless Card.where(id: card_ids).count == card_ids.size # detects invalid card ids

    card_ids.each do |card_id|
      DeckCard.create(deck_id: deck.id, card_id:)
    end
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

  def modify_deck_string_before_save
    puts 'Modifying Deck Code'
    self.deck_code = generate_deck_code
  end


  # validation to ensure that each card has an appropriate count
  def validate_deck_card_count
    return if generation_status == 'Initialized' || generation_status.nil?
    
    p "Validating Card Count [#{generation_status}]"

    card_counts = cards.group(:id, :rarity).count

    card_counts.each do |attributes, current_count|
      current_id = attributes[0]
      rarity = attributes[1]
      max_limit = Card.deck_limits_per_card_rarity[rarity]

      next unless current_count > max_limit

       # p "Invalid Card Count Found x0x0x0x00x0x0x0x0x0x00x0x0x0x0x0x00x0x0x0x"
      errors.add(:base,
                 "Invalid Card Quantities found for [#{Card.find_by(id: current_id).name}].  Maximum cards: #{max_limit}, found #{current_count}")
    end
  end


  def get_card_counts
    card_counts = cards.group(:id, :rarity).count
  end


  def correct_number_of_cards_in_deck
    deck_size = 30
    card_counts = cards.group(:id, :deck_size_modifier_type, deck_size_modifier_count).count

    additional = 0
    subtraction = 0
    override = 0

    card_counts.each do |(card_id, deck_size_modifier_type, deck_size_modifier_count), count|
    end

    deck.cards == deck_size
  end


  def modify_deck_code
    return if generation_status == 'Initialized' || generation_status.nil?

    unless persisted?
      p "Modifying DeckCode"
      original_deck_card_ids = Deck.find(id).deck_card_ids.sort
      current_deck_card_ids = deck_card_ids.sort
  
      return if original_deck_card_ids == current_deck_card_ids
  
      self.deck_code = generate_deck_code
    else
      p "Creating Deck Code"
      self.deck_code = generate_deck_code
    end

  end
end

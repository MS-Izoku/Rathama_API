require 'json'
require 'base64'

class Deck < ApplicationRecord
  has_many :deck_cards, dependent: :destroy
  has_many :cards, through: :deck_cards
  belongs_to :user, class_name: 'User', foreign_key: 'owner_id'

  validate :validate_deck_count # custom validation required due to possible deck-size modification via cards
  validate :validate_deck_player_class  # custom validation for dual-class decks (cannot include 3 non-neutral classes)
  
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
    %w[Initialized GameReady NotReady]
  end


  # generate a Base64 Deck Code out of the associated Cards in the deck
  def generate_deck_code(debug = false)
    # Combine card IDs and counts into a string
    card_string = cards.map { |card| "#{card[:id]}-#{card[:count]}" }.join(',')
    card_string = "[#{card_string}]"

    player_class_identifier = '[Class Identifier]'
    # Construct the deck string: [Name],[Class],[CardString]
    deck_string = "#{name},#{player_class_identifier},#{card_string}"

    # Base64 encode the deck string
    full_code = Base64.strict_encode64(deck_string)

    full_code
  end

  # Validate the Deck Code against all generation methods
  def validate_deck_code
    validate_checksum # Call validate_checksum internally
  end


  # a method to create a deck and cards using a single transaction
  def self.create_deck_from_params(input_params, user_id)
    card_list = input_params[:card_ids]

    deck = Deck.new(input_params.except(:card_ids))
    deck.owner_id = user_id
    deck.generation_status = 'Initialized'
    deck.save!

    return deck unless Deck.create_deck_cards(deck, card_list)

    deck.generation_status = 'GameReady'
    deck.save
    deck
  end


  # update the card list of a given Deck
  def self.update_card_list(deck, card_ids)
    new_decklist = card_ids # this is an array/list of integers
    return if new_decklist == deck.deck_cards.pluck(:id) # return if the card_ids already match

    valid_cards = Card.where(id: card_ids.uniq, is_generated_card: false)
    valid_card_ids = valid_cards.pluck(:id)
    invalid_ids = card_ids - valid_card_ids

    # check if all cards exist
    unless invalid_ids.count == 0
      deck.errors.add(:base, "Invalid Card Id#{invalid_ids.count > 1 ? 's' : ''} Found::#{invalid_ids}")
      return false
    end

    current_card_list = deck.deck_cards.pluck(:card_id)

    cards_to_remove = current_card_list - valid_card_ids
    cards_to_add = valid_card_ids - current_card_list
  
    # Remove cards that are no longer in the updated list
    deck.deck_cards.where(card_id: cards_to_remove).destroy_all
  
    # Add new cards to the deck
    cards_to_add.each do |card_id|
      deck.deck_cards.create(card_id: card_id)
    end

    deck
  end


  # a method to create and destroy Deck Cards for a given deck
  # can also be used using a partial-list during Update instead of a full list during create
  def self.create_deck_cards(deck, card_ids)
    valid_cards = Card.where(id: card_ids.uniq, is_generated_card: false)
    valid_card_ids = valid_cards.pluck(:id)
    invalid_ids = card_ids - valid_card_ids

    # check if all cards exist
    unless invalid_ids.count == 0
      deck.errors.add(:base, "Invalid Card Id#{invalid_ids.count > 1 ? 's' : ''} Found::#{invalid_ids}")
      return false
    end

    card_ids.each do |card_id|
      DeckCard.create(deck_id: deck.id, card_id:)
    end

    true
  end

  #  START OF PRIVATE / VALIDATIONS
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
  def validate_deck_count
    return if generation_status == 'Initialized' || generation_status.nil?

    p 'Validating Card Count'

    card_counts = cards.group(:id, :rarity).count

    card_counts.each do |attributes, current_count|
      current_id = attributes[0]
      rarity = attributes[1]
      max_limit = Card.deck_limits_per_card_rarity[rarity]

      next unless current_count > max_limit

      errors.add(:base,
                 "Invalid Card Quantities found for [#{Card.find_by(id: current_id).name}].  Maximum cards: #{max_limit}, found #{current_count}")
    end

    deck_size_modifier_cards = cards.where.not(deck_size_modifier_type: 'None')

    deck_limit = 30
    override_cards = deck_size_modifier_cards.where(deck_size_modifier_type: 'Override')

    if override_cards.count > 1
      errors.add(:base, "Deck can only include 1 Deck-Size Override Card, found:: #{override_cards.count}")
      return self
    elsif override_cards.count == 1
      deck_limit = override_cards[0].deck_size_modifier_value
      p "Deck Requirement is now::#{deck_limit}"
    end

    deck_size_modifier_cards.each do |modifier_card|
      p "Modifing Deck with Values:: #{modifier_card.deck_size_modifier_type} #{modifier_card.deck_size_modifier_value}"
      case modifier_card.deck_size_modifier_type
      when 'Add'
        deck_limit += modifier_card.deck_size_modifier_value
      when 'Subtract'
        deck_limit -= modifier_card.deck_size_modifier_value
      when 'Override' || 'None'
        next
      else
        errors.add(:base, "Invalid Modifer Type Found [#{deck_size_modifier_cards.deck_size_modifier_type}]")
      end
    end

    p "Deck Limit Requirement is::#{deck_limit}"
    errors.add(:base, "Deck size cannot be zero or negative, currently::#{deck_limit}") unless deck_limit > 0

    # adjust playability here
    p "Current Deck Cards:: #{deck_cards.count} || Expecting::#{deck_limit}"
    if deck_limit > deck_cards.count
      self.is_playable = false
      self.playability_status = 'Too Few Cards'
    elsif deck_limit < deck_cards.count
      self.is_playable = false
      self.playability_status = 'Too Many Cards'
    else
      self.is_playable = true
      self.playability_status = 'Ready'
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

    if persisted?
      p 'Creating Deck Code'
      self.deck_code = generate_deck_code
    else
      p 'Modifying DeckCode'
      original_deck_card_ids = Deck.find(id).deck_card_ids.sort
      current_deck_card_ids = deck_card_ids.sort

      return if original_deck_card_ids == current_deck_card_ids

      self.deck_code = generate_deck_code
    end
  end

  def validate_deck_player_class
     classes = cards.where.not(player_class_id: 0).pluck(:player_class_id)     
     errors.add(:base, "Too Many Classes in this Deck") if classes.count > 2
  end

end

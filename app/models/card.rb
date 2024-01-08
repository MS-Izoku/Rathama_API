class Card < ApplicationRecord
# region: relationships

  # Player Class/es of the Card (In Case of Dual+ Class Cards)
  has_many :player_class_cards
  has_many :player_classes, through: :player_class_cards

  # Cards have many CardTypeAttributes, being either Tribes or SpellSchools (validated on other models)
  has_many :card_types
  has_many :card_type_attributes, through: :card_types

# endregion


  # presence checks
  validates :name, :card_text, :cost, :flavor_text, :rarity, :card_art_url, presence: true

  # uniqueness checks
  validates :name, uniqueness: { scope: :is_token, if: :should_validate_uniqueness_if_token? }
  validates :card_art_url, uniqueness: true
  validates :flavor_text, uniqueness: true
  validates :cost, numericality: { greater_than_or_equal_to: -1 }

# region: Card Type Checks
  def fiend_card?
    type == 'FiendCard'
  end

  def spell_card?
    type == 'SpellCard'
  end

  def trap_card?
    type == 'TrapCard'
  end

  def weapon_card?
    type == 'WeaponCard'
  end

  def monument_card?
    type == 'MonumentCard'
  end

  def hero_card?
    type == 'HeroCard'
  end
# endregion


  # region Card Rarity and Deck Limits
  def self.valid_rarities
    deck_limits_per_card_rarity.keys
  end

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
  
# endregion


  private

  def validate_player_class_requirements
    # a Card cannot belong to more than 2 classes
    if player_class_cards.count > 2

      neutral_association_count = player_class_cards.joins(:player_class).where(player_classes: { name: 'Neutral' }).count

      # "Neutral" (PlayerClass) cannot be an option for Dual-Class Cards (Neutral is universal between all classes)
      if neutral_association_count > 0
        errors.add(:base, 'Cards cannot be Dual Class if they are Neutral (Neutral PlayerClass found in relationship PlayerClassCard)')
      else
        errors.add(:base, 'A Card can have no more than 2 associated Player Classes.')
      end

    # A Card must have at least one PlayerClass
    elsif player_class_cards.empty?
      errors.add(:base, 'A Card must have at least one PlayerClassCard.')
    end
  end

  def should_validate_uniqueness_if_token?
    # if the card is not a token, it should have a unique name
    !is_token
  end

end

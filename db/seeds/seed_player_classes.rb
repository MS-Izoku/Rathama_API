# frozen_string_literal: true

class SeedPlayerClasses
  NEUTRAL_CLASS_NAME = 'Neutral'

  def self.seed
    create_initial_classes
    create_new_classes
  end

  def self.create_initial_classes
    # setting Ids will be done manually here to prevent any weird asscociations
    unless PlayerClass.find_by(name: NEUTRAL_CLASS_NAME)
      neutral = PlayerClass.new(
        name: NEUTRAL_CLASS_NAME,
        description: 'Cards which can be used without a class restriction'
      )
      neutral.id = 0
      neutral.save!
    end

    detainer_class = PlayerClass.find_or_create_by(
      id: 1,
      name: 'Detainer',
      description: ''
    )

    magus_class = PlayerClass.find_or_create_by(
      id: 2,
      name: 'Magus',
      description: ''
    )

    sage_class = PlayerClass.find_or_create_by(
      id: 3,
      name: 'Sage',
      description: ''
    )

    trapper_class = PlayerClass.find_or_create_by(
      id: 4,
      name: 'Trapper',
      description: ''
    )

    warden_class = PlayerClass.find_or_create_by(
      id: 5,
      name: 'Warden',
      description: ''
    )

    # Player Classes will require their own "Card" which is unobtainable by the player,
    # but is used by the game as the default Hero
    # the exception to this is the Neutral class, which is not usable by players 
    default_detainer_hero_card = HeroCard.find_or_create_by(
      name: 'Xedrai',
      card_text: '',
      armor: 0,
      cost: 0,
      rarity: 'Legendary',
      expansion_id: 1,
      flavor_text: '<p>The default <b>Detainer</b> Hero</p>'
    )
    PlayerClassCard.create(player_class: detainer_class, card: default_detainer_hero_card)

    default_magus_hero_card = HeroCard.find_or_create_by(
      name: 'Magai',
      card_text: '',
      armor: 0,
      cost: 0,
      rarity: 'Legendary',
      expansion_id: 1,
      flavor_text: '<p>The default <b>Magus</b> Hero</p>'
    )
    PlayerClassCard.create(player_class: magus_class, card: default_magus_hero_card)

    default_sage_hero_card = HeroCard.find_or_create_by(
      name: 'Dianaria',
      card_text: '',
      armor: 0,
      cost: 0,
      rarity: 'Legendary',
      expansion_id: 1,
      flavor_text: '<p>The default <b>Sage</b> Hero</p>'
    )
    PlayerClassCard.create(player_class: sage_class, card: default_sage_hero_card)

    default_trapper_hero_card = HeroCard.find_or_create_by(
      name: 'Xedrai',
      card_text: '',
      armor: 0,
      cost: 0,
      rarity: 'Legendary',
      expansion_id: 1,
      flavor_text: '<p>The default <b>Detainer</b> Hero</p>'
    )
    PlayerClassCard.create(player_class: trapper_class, card: default_trapper_hero_card)

    default_warden_hero_card = HeroCard.find_or_create_by(
      name: 'Xedrai',
      card_text: '',
      armor: 0,
      cost: 0,
      rarity: 'Legendary',
      expansion_id: 1,
      flavor_text: '<p>The default <b>Detainer</b> Hero</p>'
    )
    PlayerClassCard.create(player_class: warden_class, card: default_warden_hero_card)
  end
end

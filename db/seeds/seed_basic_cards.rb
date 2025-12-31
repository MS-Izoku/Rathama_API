# frozen_string_literal: true

class SeedBasicCards
  def self.seed
    seed_neutral_cards
    seed_detainer_cards
    seed_magus_cards
    seed_sage_cards
    seed_trapper_cards
    seed_warden_cards
  end

  def self.seed_neutral_cards
      # region: Heroes
      # endregion

      # region: Fiends

      # endregion

      # region: Monuments
      # endregion

      # region: Spells
      # endregion

      # region: Traps
      # endregion

      # region: Weapon
      # endregion
  end

  def self.seed_detainer_cards
    detainer_cards = []
      # region: Heroes
      # endregion

      # region: Fiends
    grasping_hands = FiendCard.find_or_create_by(
      name: 'The Grasping Hands',
      flavor_text: 'Why are there so many of them?',
      rarity: 'Legendary',
      cost: 5,
      card_text: '',
      is_generated_card: false,
      deck_size_modifier_type: 'None',
      expansion_id: 1,
      attack: 2,
      health: 10
    )
    detainer_cards << grasping_hands

    FiendCard.find_or_create_by(
      name: 'Creeping Hand',
      flavor_text: 'Why is this thing moving?',
      rarity: 'Rare',
      cost: 2,
      card_text: '',
      is_generated_card: false,
      deck_size_modifier_type: 'None',
      expansion_id: 1,
      attack: 2,
      health: 5
    )

    FiendCard.find_or_create_by(
      name: 'Hungry Hand',
      flavor_text: 'Why is this thing hungry?',
      rarity: 'Rare',
      cost: 2,
      card_text: '',
      is_generated_card: false,
      deck_size_modifier_type: 'None',
      expansion_id: 1,
      attack: 2,
      health: 5
    )

    FiendCard.find_or_create_by(
      name: 'Giant Hand',
      flavor_text: 'Why is this thing so big',
      rarity: 'Rare',
      cost: 4,
      card_text: '<b>Bastion</b>',
      is_generated_card: false,
      deck_size_modifier_type: 'None',
      expansion_id: 1,
      attack: 1,
      health: 10
    )

    FiendCard.find_or_create_by(
      name: 'Skinless Hand',
      flavor_text: "Where'd the skin go?",
      rarity: 'Rare',
      cost: 3,
      card_text: '<b>Anim</b>',
      is_generated_card: false,
      deck_size_modifier_type: 'None',
      expansion_id: 1,
      attack: 3,
      health: 3
    )

    
    FiendCard.find_or_create_by(
      name: 'Another Hand',
      flavor_text: "Why are there so many?",
      rarity: 'Rare',
      cost: 3,
      card_text: '<b>Anim</b>',
      is_generated_card: false,
      deck_size_modifier_type: 'None',
      expansion_id: 1,
      attack: 3,
      health: 3
    )

      # endregion

      # region: Monuments
    MonumentCard.find_or_create_by(
      name: 'Portal of Hands',
      flavor_text: "Oh, so now there's a portal for them now",
      rarity: 'Rare',
      cost: 3,
      card_text: '',
      is_generated_card: false,
      deck_size_modifier_type: 'None',
      expansion_id: 1,
      durability: 10
    )
      # endregion

      # region: Spells
    SpellCard.find_or_create_by(
      name: 'Hand of Glory',
      flavor_text: 'Glorious',
      rarity: 'Common',
      expansion_id: 1,
      deck_size_modifier_type: 'None',
      card_text: '',
      is_generated_card: false,
      cost: 2
    )

    SpellCard.find_or_create_by(
      name: 'Hand of Passion',
      flavor_text: 'Passion..ious',
      rarity: 'Common',
      expansion_id: 1,
      deck_size_modifier_type: 'None',
      card_text: '',
      is_generated_card: false,
      cost: 2
    )

    SpellCard.find_or_create_by(
      name: 'Hand of Wonder',
      flavor_text: 'Glorious',
      rarity: 'Wonderous',
      expansion_id: 1,
      deck_size_modifier_type: 'None',
      card_text: '',
      is_generated_card: false,
      cost: 2
    )

    SpellCard.find_or_create_by(
      name: 'Hand of Knowledge',
      flavor_text: 'Knowledgable',
      rarity: 'Common',
      expansion_id: 1,
      deck_size_modifier_type: 'None',
      card_text: '',
      is_generated_card: false,
      cost: 2
    )

    SpellCard.find_or_create_by(
      name: 'Hand of Metamorphasis',
      flavor_text: 'Metamorphasizing',
      rarity: 'Common',
      expansion_id: 1,
      deck_size_modifier_type: 'None',
      card_text: '',
      is_generated_card: false,
      cost: 2
    )

    SpellCard.find_or_create_by(
      name: 'Hand of Stasis',
      flavor_text: 'Stasilicious',
      rarity: 'Common',
      expansion_id: 1,
      deck_size_modifier_type: 'None',
      card_text: '',
      is_generated_card: false,
      cost: 2
    )
      # endregion

      # region: Traps
    TrapCard.find_or_create_by(
      name: 'Pillory',
      flavor_text: 'Made for hands only, like a lot of hands',
      rarity: 'Common',
      expansion_id: 1,
      deck_size_modifier_type: 'None',
      card_text: '',
      is_generated_card: false,
      cost: 2
    )

    TrapCard.find_or_create_by(
      name: 'Quick Cuff',
      flavor_text: "For pesky hands going where they don't belong",
      rarity: 'Common',
      expansion_id: 1,
      deck_size_modifier_type: 'None',
      card_text: '',
      is_generated_card: false,
      cost: 2
    )

    TrapCard.find_or_create_by(
      name: 'Binding Maiden',
      flavor_text: "I'd hate to get caught in that thing",
      rarity: 'Common',
      expansion_id: 1,
      deck_size_modifier_type: 'None',
      card_text: '',
      is_generated_card: false,
      cost: 2
    )
      # endregion

      # region: Weapon
    WeaponCard.find_or_create_by(
      name: 'Ritual Chain',
      flavor_text: 'So many links, so little time',
      rarity: 'Rare',
      cost: 2,
      card_text: '',
      is_generated_card: false,
      deck_size_modifier_type: 'None',
      expansion_id: 1,
      attack: 2,
      durability: 3
    )
      # endregion

    detainer_class = PlayerClass.find_by(name: 'Detainer')
    detainer_cards.each do |_card|
      PlayerClassCard.create(player_class: detainer_class, card: card)
    end
  end

  def self.seed_magus_cards
      # region: Heroes
      # endregion

      # region: Fiends
    FiendCard.find_or_create_by(
      name: 'Krakari the Whorl',
      flavor_text: 'Krakari',
      rarity: 'Legendary',
      expansion_id: 1,
      deck_size_modifier_type: 'None',
      card_text: '',
      is_generated_card: false,
      attack: 3,
      health: 10,
      armor: 0,
      cost: 2
    )

    FiendCard.find_or_create_by(
      name: 'Krakari the Whorl 2',
      flavor_text: 'Krakari 1',
      rarity: 'Legendary',
      expansion_id: 1,
      deck_size_modifier_type: 'None',
      card_text: '',
      is_generated_card: false,
      attack: 3,
      health: 10,
      armor: 0,
      cost: 2
    )

    FiendCard.find_or_create_by(
      name: 'Hands of the Sea',
      flavor_text: 'A mass of hands bound together by some unknown force, which drags its victims to the bottom of the sea.',
      rarity: 'Legendary',
      expansion_id: 1,
      deck_size_modifier_type: 'None',
      card_text: '',
      is_generated_card: false,
      attack: 3,
      health: 10,
      armor: 0,
      cost: 2
    )

    FiendCard.find_or_create_by(
      name: 'Demon Prophet Bisho',
      flavor_text: 'Krakari 1',
      rarity: 'Legendary',
      expansion_id: 1,
      deck_size_modifier_type: 'None',
      card_text: '',
      is_generated_card: false,
      attack: 3,
      health: 10,
      armor: 0,
      cost: 2
    )
      # endregion

      # region: Monuments
      # endregion

      # region: Spells
    SpellCard.find_or_create_by(
      name: 'Whorl',
      flavor_text: 'Whirl on these bitches',
      rarity: 'Common',
      expansion_id: 1,
      deck_size_modifier_type: 'None',
      card_text: '',
      is_generated_card: false,
      cost: 2
    )

    SpellCard.find_or_create_by(
      name: 'Crack',
      flavor_text: 'Crack on these bitches',
      rarity: 'Common',
      expansion_id: 1,
      deck_size_modifier_type: 'None',
      card_text: '',
      is_generated_card: false,
      cost: 2
    )

    SpellCard.find_or_create_by(
      name: 'Surge',
      flavor_text: 'Surge on these bitches',
      rarity: 'Common',
      expansion_id: 1,
      deck_size_modifier_type: 'None',
      card_text: '',
      is_generated_card: false,
      cost: 2
    )
      # endregion

      # region: Traps
    TrapCard.find_or_create_by(
      name: 'Surprise Whorl',
      flavor_text: 'Whirl on these bitches, but as a trap',
      rarity: 'Common',
      expansion_id: 1,
      deck_size_modifier_type: 'None',
      card_text: '',
      is_generated_card: false,
      cost: 2
    )

    TrapCard.find_or_create_by(
      name: 'Surprise Crack',
      flavor_text: 'Crack on these bitches, but as a trap',
      rarity: 'Common',
      expansion_id: 1,
      deck_size_modifier_type: 'None',
      card_text: '',
      is_generated_card: false,
      cost: 2
    )

    TrapCard.find_or_create_by(
      name: 'Surprise Surge',
      flavor_text: 'Surge on these bitches, but as a trap',
      rarity: 'Common',
      expansion_id: 1,
      deck_size_modifier_type: 'None',
      card_text: '',
      is_generated_card: false,
      cost: 2
    )
      # endregion

      # region: Weapon
      # endregion
  end

  def self.seed_sage_cards
      # region: Heroes
      # endregion

      # region: Fiends
    FiendCard.find_or_create_by(
      name: 'Demon Prophet Opa',
      flavor_text: 'The original demon prophet of Kureko, a fragment of the great beast',
      rarity: 'Legendary',
      expansion_id: 1,
      deck_size_modifier_type: 'None',
      card_text: '',
      is_generated_card: false,
      attack: 3,
      health: 10,
      armor: 0,
      cost: 2
    )

    FiendCard.find_or_create_by(
      name: 'Kureko, Mockery of 10 Tails',
      flavor_text: 'The plague of Koden, a mockery of Great Rekkakuu',
      rarity: 'Legendary',
      expansion_id: 1,
      deck_size_modifier_type: 'None',
      card_text: '',
      is_generated_card: false,
      attack: 3,
      health: 10,
      armor: 0,
      cost: 2
    )

    FiendCard.find_or_create_by(
      name: 'Ikariki, Wrigling Fangs of Kureko',
      flavor_text: 'One of the 5 Demon Generals of Kureko, whose firey fangs writher like tentacles.',
      rarity: 'Legendary',
      expansion_id: 1,
      deck_size_modifier_type: 'None',
      card_text: '',
      is_generated_card: false,
      attack: 3,
      health: 10,
      armor: 0,
      cost: 2
    )
      # endregion

      # region: Monuments
    MonumentCard.find_or_create_by(
      name: 'Reaper Gate Statue',
      flavor_text: 'An ancient gate, buried due to its ability to unseal any jutsu',
      rarity: 'Legendary',
      expansion_id: 1,
      deck_size_modifier_type: 'None',
      card_text: '',
      is_generated_card: false,
      attack: 3,
      health: 10,
      armor: 0,
      cost: 2
    )

    MonumentCard.find_or_create_by(
      name: '5 Towers of Koden',
      flavor_text: '5 towers atop a tower near Koden, holding the 5 generals of Kureko',
      rarity: 'Legendary',
      expansion_id: 1,
      deck_size_modifier_type: 'None',
      card_text: '',
      is_generated_card: false,
      attack: 3,
      health: 10,
      armor: 0,
      cost: 2
    )

      # endregion

      # region: Spells
      # endregion

      # region: Traps
      # endregion

      # region: Weapon
      # endregion
  end

  def self.seed_trapper_cards
      # region: Heroes
      # endregion

      # region: Fiends
    FiendCard.find_or_create_by(
      name: 'Eloquence',
      card_text: '<p><strong>Call:</strong> <strong>Form</strong> an <em>Eloquent Lie</em></p><p><strong>Rale:</strong> Summon <em>The Hungering Tongue</em></p>',
      flavor_text: '<p>Ribbit? Ribbit...</p>',
      cost: 8,
      attack: 5,
      health: 10,
      rarity: 'Legendary',
      cost: 2
    )
      # endregion

      # region: Monuments
      # endregion

      # region: Spells
      # endregion

      # region: Traps
          # example use: <strong>Form</strong> and a Quickshot at the end of your turn.
    TrapCard.find_or_create_by(
      name: 'Sand Shot',
      card_text: '<p>When an Enemy attacks, deal 1 Damage to 2 Random Enemies.</p><p>Enemies hit cannot attack this turn.</p>',
      flavor_text: '<p>Hey buddy watch this</p>',
      cost: 2,
      rarity: 'Common'
    )

    TrapCard.find_or_create_by(
      name: 'Scrape Pocket',
      card_text: '<p>When your Opponent activates one of your traps, <strong>Find</strong> and cast another from your hand or deck</p>',
      flavor_text: '<p>Scrape me daddy</p>',
      cost: 2,
      rarity: 'Common'
    )

    TrapCard.find_or_create_by(
      name: 'Flare Snare',
      card_text: '<p>When an enemy <strong>Call</strong> is triggered, <strong>Gag</strong> all enemy minions.</p><p>Then deal 2 damage to all enemies.</p>',
      flavor_text: '<p>Made you look, but on fire</p>',
      cost: 2,
      rarity: 'Common'
    )

    TrapCard.find_or_create_by(
      name: 'Spell Snare',
      card_text: '<p>When an enemy Trap or Spell targets a friendly character, summon a 1/3 Token as its target.</p>',
      flavor_text: '<p>Made you look, but magical</p>',
      cost: 2,
      rarity: 'Common'
    )

    TrapCard.find_or_create_by(
      name: 'Haunting Howl',
      card_text: '<p>When a friendly Rale is activated on your Opponents turn, trigger it two more times.</p>',
      flavor_text: '<p>We heard you already</p>',
      cost: 2,
      rarity: 'Common'
    )

    TrapCard.find_or_create_by(
      name: 'Avarice of Prey',
      card_text: '<p>When an enemy Trap or Spell is activated, deal its cost to the enemy Hero (max 6 damage)</p>',
      flavor_text: '<p>Hey buddy watch this, with avarice</p>',
      cost: 2,
      rarity: 'Common'
    )

    TrapCard.find_or_create_by(
      name: 'Quick Shot',
      card_text: '<p>Deal 2 damage to the enemy hero</p>',
      flavor_text: '<p>Hey buddy watch this, quickly</p>',
      cost: 2,
      rarity: 'Common'
    )

    TrapCard.find_or_create_by(
      name: 'Stratified Pit',
      card_text: '<p>When another friendly Trap is activated, play two random Traps from your deck.</p><p>They cannot activate this turn</p>',
      flavor_text: '<p>Stratified</p>',
      cost: 2,
      rarity: 'Rare'
    )

    TrapCard.find_or_create_by(
      name: 'Eloquent Lie: Locusta',
      card_text: '<p>When your opponent attacks with a Fiend, add a copy to your hand.</p><p>Set its Stats and Cost to (2)</p>',
      flavor_text: '<p>Locusta</p>',
      cost: 2,
      rarity: 'Rare'
    )

    TrapCard.find_or_create_by(
      name: 'Eloquent Lie: Humano',
      card_text: '<p>When one of your Fiends die, return it to your hand.</p><p>It costs (2) less.</p>',
      flavor_text: '<p>Humano</p>',
      cost: 2,
      rarity: 'Rare'
    )

    TrapCard.find_or_create_by(
      name: 'Eloquent Lie: Equis',
      card_text: '<p>When your opponent attacks with a Fiend, return it to their hand.</p><p>It costs (2) more.</p>',
      flavor_text: '<p>Equis</p>',
      cost: 2,
      rarity: 'Rare'
    )
          # endregion

          # region: Spells
    SpellCard.find_or_create_by(
      name: 'Frog Song',
      card_text: '<p>Destroy all in-play traps.</p><p>Traps in your hand cost (0) for 2 turns</p>',
      flavor_text: '<p>Ribbit</p>',
      cost: 4,
      rarity: 'Rare'
    )
      # endregion

      # region: Weapon
      # endregion
  end

  def self.seed_warden_cards
          # region: Heroes
          # endregion

          # region: Fiends
    FiendCard.find_or_create_by(
      name: 'The Walking Festival',
      card_text: "<p><strong>Giant(4)</strong></p><p><strong>Dawn:</strong>If you control less than 4 Festival's legs, summon one.</p>",
      flavor_text: '<p>One Big Boi</p>',
      cost: 8,
      attack: 5,
      health: 10,
      rarity: 'Legendary'
    )

    FiendCard.find_or_create_by(
      name: "Festival's Leg",
      card_text: "<p><strong>Giant(4)</strong></p><p><strong>Dawn:</strong>If you control less than 4 Festival's legs, summon one.</p>",
      flavor_text: "<p>OH GOD IT'S...oh nevermind</p>",
      cost: 8,
      attack: 5,
      health: 10,
      rarity: 'Legendary'
    )
      # endregion

      # region: Monuments
      # endregion

      # region: Spells
      # endregion

      # region: Traps
      # endregion

      # region: Weapon
      # endregion
  end
end

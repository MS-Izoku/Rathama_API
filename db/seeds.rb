# region: Card Type Attribute

angelic = Tribe.create!(name: 'Angelic', description: 'Those that resemble angels, or mock them')
aquatic = Tribe.create!(name: 'Aquatic', description: 'Those that dwell underwater')
chimera = Tribe.create!(name: 'Chimera', description: 'Beats and those who resemble them')
dream = Tribe.create!(name: 'Dream',
                      description: 'Strange, sometimes Eldritch creatures that often defy even the most vivid imagination')
ghost = Tribe.create!(name: 'Ghost', description: 'Those that resemble the undead or ghastly creatures from beyond')
golem = Tribe.create!(name: 'Golem', description: 'Constructs given what some would consider life')
mimic = Tribe.create!(name: 'Mimic', description: 'Those who imitate the humanoid or bipedal shape')

# spell schools
alchemic = SpellSchool.create!(name: 'Alchemic',
                               description: 'Potions and circle-based spells which involve exhanges.  Equivilent exchange if you will')
magic = SpellSchool.create!(name: 'Magic',
                            description: 'What many would consider stereotypical magic.  Chants and intellect are a defining factors, but at a cost.')
chakra = SpellSchool.create!(name: 'Chakra',
                             description: 'The magic of the body, internal workings made manifest.  Often exhausting, but with uniquely regenerative and body-enhancing capabilities.')
illusion = SpellSchool.create!(name: 'Illusion',
                               description: "Forcing the enemy to see what you want them to see, or perhaps yourself if you're clever.")

divine = SpellSchool.create!(name: 'Divine',
                             description: 'Spells that invoke the power of the gods themselves, rare and powerful')
talismanic = SpellSchool.create!(name: 'Talismanic',
                                 description: 'Spells invoked from powerful artifacts, which do not make great or useful weapons.  Possibly expendable or cheap.')

# Elements
fire = SpellSchool.create!(name: 'Fire', description: 'Spells that control the element of fire')
ice = SpellSchool.create!(name: 'Ice', description: 'Spells that control the element of ice and water')
earth = SpellSchool.create!(name: 'Earth', description: 'Spells that control the element of Earth and Metal')
wood = SpellSchool.create!(name: 'Wood', description: 'Beasts')
lightning = SpellSchool.create!(name: 'Lightning', description: 'Spells that control the element of Lightning')
shadow = SpellSchool.create!(name: 'Shadow', description: 'Spells that control the element of Shadow')

# endregion

# create keywords and effects used by cards
def create_card_effects
    # db/seeds.rb

lifecycle_effects = [
  { name: "Root", format: "", description: "An effect that occurs at the start of the game." },
  { name: "Rale", format: "", description: "An effect that applies when a Minion or Hero has been destroyed after being played to the board." },
  { name: "Cusp", format: "", description: "An effect that occurs at the end of the turn." },
  { name: "Call", format: "", description: "An effect that occurs when the Card is played from the hand." },
]

positionals = [
  { name: "Nexus", format: "", description: "An effect that occurs when this card enters the Nexus space at the center of the board." },
  { name: "Rook", format: "", description: "An effect that occurs when a Rook enters a Rook space on the sides of a board." },
  { name: "Link", format: "", description: "A State shared between cards when placed between 2 Rooks or a Rook and Nexus card." },
]

generative_and_searches = [
  # Copy generates a copy of an existing card
  { name: "Copy", format: "none", description: "Generates a copy of a target." },

  # Find searches an existing pre-placed card from somewhere (most likely the deck)
  { name: "Find", format: "quanity:integer, params:[some-array-of-strings]", description: "Finds an existing card from a selection. Added to the hand by default." },
  
  # Form generates a new card from a selection of possibilities.  Sometimes, these are very specific cards
  { name: "Form", format: "quanity:integer, params:[some-array-of-strings]", description: "Generates a new card from a selection. Added to the hand by default." },
]

with_params =[
  { name: "Charge", format: "amount:integer", description: "A card that can be played X many times from hand for the same cost (ie: the card has X many charges)." },
  { name: "Lift", format: "amount:integer", description: "An effect is active when certain mana threshold is reached." },
  { name: "Giant", format: "amount:integer", description: "A minion that summons powerful token cards in x other spaces (varies depending on the fiend)." },
  { name: "Raid", format: "amount:integer", description: "Able to attack (x) times per turn." },
  
  # Spell Damage is always either +/- and some amount, never a "set value to this" kind of modifier
  { name: "Spell Damage", format: "amount:integer, type:string", description: "Increases the damage done by Spells, including Traps." },
  
  # Resurrect adds a Fiend to the Board.  It may be targeted at a specific Fiend, a selection of qualfied fiends, or decided randomly given params (which may just include ALL Fiends)
  { name: "Resurrect", format: "params:[array-of-qualifiers]", description: "Brings back a Fiend that has been destroyed on the board." },
  
  # Invoke: hero_id must always point to a specific hero card
  { name: "Invoke", format: "hero_id:integer", description: "Activates the hero power of another card." },
  
  # Evoke: possible target (targeted OR random-with-qualifier)
  { name: "Evoke", format: "target:string", description: "Summon a Fiend from your deck." },
]

# effects that act as standablone abilities
ability_effects = [
    { name: "Act", format: "none", description: "When activated, requires the player to perform a certain number of specific actions for a reward." },
    { name: "Anim", format: "none", description: "Return this to the board with 1 Health when destroyed" },
    { name: "Bane", format: "none", description: "When this deals damage, destroy the non-player target." },
    { name: "Bastion", format: "none", description: "Absorbs one hit of damage from the target before disappearing." },
    { name: "Bind", format: "none", description: "Prevent an enemy from activating an ability of a Fiend or Monument, also remove any buffs/modifications (ie: Silence from Hearthstone)" },
    { name: "Chain", format: "none", description: "An effect that occurs when this card is played after another." },
    { name: "Fury", format: "none", description: "An effect that occurs when the target is damaged." },
    { name: "Gag", format: "none", description: "Removes any/all effects from the target." },
    { name: "Hail", format: "none", description: "Find 3 cards from your deck, pick one to put on top." },
    { name: "Inspire", format: "none", description: "An effect that activates when the Scales are used." },
    { name: "Mime", format: "none", description: "Can be played as many times as possible, for the base mana cost." },
    { name: "Overkill", format: "none", description: "An effect that occurs when damage is greater than the health of the target." },
    { name: "Pact", format: "none", description: "An effect that becomes active after (x) friendly minions die while this is in hand." },
    { name: "Rite", format: "none", description: "Complete a set of specific steps to obtain a reward." },
    { name: "Rush", format: "none", description: "Can attack enemy minions immediately." },
    { name: "Sap", format: "none", description: "Restores a player's health based on the damage dealt." },
    { name: "Sly", format: "none", description: "Cannot be targeted by Spells or Scale Powers." },
    { name: "Stand", format: "none", description: "An effect that occurs when this minion survives damage." },
    { name: "Storm", format: "none", description: "Can attack any enemy character immediately." },
    { name: "Trade", format: "none", description: "Shuffle this card back into your deck and draw a new card." },
    { name: "Veil", format: "none", description: "Cannot be targeted until this attacks." },
    { name: "Ward", format: "none", description: "Enemy minions must attack this." }
  ]

  non_keyword_effects = [
    { name: "PlayGeneratedCard", format: "card_id:integer", description: "Play the effect of a generated card, which is not contained in a deck" },
    
    # Destroy a card on the field.  It can be either random or targeted, and if targeted, may have some extra qualifiers/parameters
    { name: "DestroyOnField", format: "target_type:string", description: "Destroy a card on the field, given certain params" },

    # shuffle a target back into the deck.  Can be either random or targeted
    { name: "ShuffleTargetIntoDeck", format: "target_type:string", description: "Destroy a card on the field, given certain params" },
  ]
  
  card_effects.each do |effect|
    CardEffect.find_or_create_by(effect)
  end
  
  puts "Seeded #{CardEffect.count} card effects!"
  
end
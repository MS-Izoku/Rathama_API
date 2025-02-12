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

card_effects = [
    { name: "Act", format: "", description: "When activated, requires the player to perform a certain number of specific actions for a reward." },
    { name: "Anim", format: "", description: "" },
    { name: "Bane", format: "", description: "When this deals damage, destroy the non-player target." },
    { name: "Bastion", format: "", description: "Absorbs one hit of damage from the target before disappearing." },
    { name: "Bind", format: "", description: "" },
    { name: "Call", format: "", description: "An effect that occurs when the Card is played from the hand." },
    { name: "Chain", format: "", description: "An effect that occurs when this card is played after another." },
    { name: "Copy", format: "", description: "Generates a copy of a target." },
    { name: "Cusp", format: "", description: "An effect that occurs at the end of the turn." },
    { name: "Charge(x)", format: "", description: "A card that can be played X many times from hand for the same cost (ie: the card has X many charges)." },
    { name: "Evoke", format: "", description: "Summon a minion from your deck." },
    { name: "Find", format: "", description: "Finds an existing card from a selection. Added to the hand by default." },
    { name: "Form", format: "", description: "Generates a new card from a selection. Added to the hand by default." },
    { name: "Fury", format: "", description: "An effect that occurs when the target is damaged." },
    { name: "Gag", format: "", description: "Removes any/all effects from the target." },
    { name: "Giant(x)", format: "", description: "A minion that summons powerful token cards in x other spaces (varies depending on the fiend)." },
    { name: "Hail", format: "", description: "Find 3 cards from your deck, pick one to put on top." },
    { name: "Inspire", format: "", description: "An effect that activates when the Scales are used." },
    { name: "Invoke", format: "", description: "Activates the hero power of another card." },
    { name: "Lift(x)", format: "", description: "An effect is active when certain mana threshold is reached." },
    { name: "Link", format: "", description: "A State shared between cards when placed between 2 Rooks or a Rook and Nexus card." },
    { name: "Mime", format: "", description: "Can be played as many times as possible, for the base mana cost." },
    { name: "Nexus", format: "", description: "An effect that occurs when this card enters the Nexus space at the center of the board." },
    { name: "Overkill", format: "", description: "An effect that occurs when damage is greater than the health of the target." },
    { name: "Pact", format: "", description: "An effect that becomes active after (x) friendly minions die while this is in hand." },
    { name: "Raid(X)", format: "", description: "Able to attack (x) times per turn." },
    { name: "Rale", format: "", description: "An effect that applies when a Minion or Hero has been destroyed after being played to the board." },
    { name: "Resurrect", format: "", description: "Brings back a Minion that has been destroyed on the board." },
    { name: "Rite", format: "", description: "Complete a set of specific steps to obtain a reward." },
    { name: "Rook", format: "", description: "An effect that occurs when a Rook enters a Rook space on the sides of a board." },
    { name: "Root", format: "", description: "An effect that occurs at the start of the game." },
    { name: "Rush", format: "", description: "Can attack enemy minions immediately." },
    { name: "Sap", format: "", description: "Restores a player's health based on the damage dealt." },
    { name: "Sly", format: "", description: "Cannot be targeted by Spells or Scale Powers." },
    { name: "Spell Damage", format: "", description: "Increases the damage done by Spells, including Traps." },
    { name: "Stand", format: "", description: "An effect that occurs when this minion survives damage." },
    { name: "Storm", format: "", description: "Can attack any enemy character immediately." },
    { name: "Trade", format: "", description: "Shuffle this card back into your deck and draw a new card." },
    { name: "Veil", format: "", description: "Cannot be targeted until this attacks." },
    { name: "Ward", format: "", description: "Enemy minions must attack this." }
  ]
  
  card_effects.each do |effect|
    CardEffect.find_or_create_by(effect)
  end
  
  puts "Seeded #{CardEffect.count} card effects!"
  
end
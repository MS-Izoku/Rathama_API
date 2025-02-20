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

# region: CardMechanics

def create_lifecycle_mechanics
    CardMechanic.create!(name: 'Root', description: 'Effect occurs at the start of the game', args: '')
    CardMechanic.create!(name: 'Dawn', description: 'An effect that occurs at the start of the turn', args: '')

    # does not exist on SpellCards and TrapCards
    CardMechanic.create!(name: 'Call', description: 'An effect that occurs when the card is played from hand', args: '')
    
    CardMechanic.create!(name: 'AttackDeclared', description: 'An effect that occurs at the end of the turn', args: '')
    CardMechanic.create!(name: 'TargetedForAttack', description: 'An effect that occurs at the end of the turn', args: '')
    CardMechanic.create!(name: 'DamageStep', description: 'An effect that occurs at the end of the turn', args: '')
    CardMechanic.create!(name: 'PostAttackStep', description: 'An effect that occurs at the end of the turn', args: '')
    CardMechanic.create!(name: 'OnDamaged', description: 'An effect that occurs at the end of the turn', args: '')

    CardMechanic.create!(name: 'Rale', description: 'Effect occurs when this card is destroyed', args: '')

    # card-type specific mechanics
    CardMechanic.create!(name: 'OnSpellActivate', description: 'Effect occurs when this card is destroyed', args: '')
    CardMechanic.create!(name: 'OnTrapActivate', description: 'Effect occurs when this card is destroyed', args: '')
    CardMechanic.create!(name: 'OnMonumentActivate', description: 'Effect occurs when this card is destroyed', args: '')
end

def create_mechanics
    CardMechanic.create!(name: 'Act', description: 'Requires the player to perform specific actions for a reward', args: 'actionCount:integer')
    CardMechanic.create!(name: 'Anim', description: 'Revives after being destroyed with 1 health', args: '')
    CardMechanic.create!(name: 'Bane', description: 'When this deals damage, destroy the non-player target', args: '')
    CardMechanic.create!(name: 'Bastion', description: 'Absorbs one hit of damage before disappearing', args: '')
    CardMechanic.create!(name: 'Bind', description: 'Prevents the target from acting on its next turn', args: '')
    CardMechanic.create!(name: 'Chain', description: 'An effect that occurs when this card is played after another', args: '')
    CardMechanic.create!(name: 'Copy', description: 'Generates a copy of a target', args: 'targetType:SingleTarget')

    CardMechanic.create!(name: 'Charge', description: 'Can be played multiple times from hand for the same cost', args: 'quantity:integer')
    CardMechanic.create!(name: 'GainCharge', description: 'Gives a quantity of Charge.  If Charge is not present, gives it Charge and sets it to (2, 1 + the quantity)', args: 'quantity:integer')

    CardMechanic.create!(name: 'Evoke', description: 'Summon a minion from your deck', args: 'targetType:SingleTarget')
    CardMechanic.create!(name: 'Find', description: 'Finds an existing card from a selection and adds it to hand', args: 'selectionSize:integer')
    CardMechanic.create!(name: 'Form', description: 'Generates a new card from a selection and adds it to hand', args: 'selectionSize:integer')
    CardMechanic.create!(name: 'Fury', description: 'An effect that occurs when this minion takes damage', args: '')
    CardMechanic.create!(name: 'Gag', description: 'Removes any/all effects from the target', args: 'targetType:SingleTarget')
    CardMechanic.create!(name: 'Giant', description: 'Summons powerful tokens in additional spaces', args: 'summonCount:integer')
    CardMechanic.create!(name: 'Hail', description: 'Find 3 cards from your deck, pick one to put on top', args: '')
    CardMechanic.create!(name: 'Inspire', description: 'Activates when the Scales are used', args: '')
    CardMechanic.create!(name: 'Invoke', description: 'Activates the hero power of another card', args: '')
    CardMechanic.create!(name: 'Lift', description: 'Effect is active when a certain mana threshold is reached', args: 'manaThreshold:integer')
    CardMechanic.create!(name: 'Link', description: 'A state shared between cards when placed between certain pieces', args: '')
    CardMechanic.create!(name: 'Mime', description: 'Can be played multiple times for the base mana cost', args: '')
    CardMechanic.create!(name: 'Nexus', description: 'Effect occurs when this card enters the Nexus space', args: '')
    CardMechanic.create!(name: 'Overkill', description: 'Effect occurs when damage exceeds target health', args: '')
    CardMechanic.create!(name: 'Pact', description: 'Effect becomes active after (x) friendly minions die in hand', args: 'minionsRequired:integer')
    CardMechanic.create!(name: 'Raid', description: 'Able to attack multiple times per turn', args: 'attacks:integer')
    CardMechanic.create!(name: 'Resurrect', description: 'Brings back a destroyed minion to the board', args: 'targetType:SingleTarget')
    CardMechanic.create!(name: 'Rite', description: 'Complete a set of steps for a reward', args: '')
    CardMechanic.create!(name: 'Rook', description: 'Effect occurs when a Rook enters a Rook space', args: '')
    CardMechanic.create!(name: 'Rush', description: 'Can attack enemy minions immediately', args: '')
    CardMechanic.create!(name: 'Sap', description: 'Restores health based on damage dealt', args: '')
    CardMechanic.create!(name: 'Sly', description: 'Cannot be targeted by Spells or Scale Powers', args: '')
    CardMechanic.create!(name: 'Spell Damage', description: 'Increases damage done by Spells and Traps', args: 'spellDamageBonus:integer')
    CardMechanic.create!(name: 'Stand', description: 'Effect occurs when this minion survives damage', args: '')
    CardMechanic.create!(name: 'Storm', description: 'Can attack any enemy character immediately', args: '')
    CardMechanic.create!(name: 'Trade', description: 'Shuffle this card into your deck and draw a new one', args: '')
    CardMechanic.create!(name: 'Veil', description: 'Cannot be targeted until this attacks', args: '')
    CardMechanic.create!(name: 'Ward', description: 'Enemy minions must attack this', args: '')
end


# endregion

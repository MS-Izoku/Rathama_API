# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize

class SeedCardMechanics
  def self.seed
    create_core_mechanics
    create_traits
    create_keywords_with_args
  end

  def self.create_core_mechanics
    CardMechanic.find_or_create_by(name: 'DealDamage', description: 'Deals Damage to something',
                                   args: 'damage:integer,target:targetType', is_trait: false)

    CardMechanic.find_or_create_by(name: 'Heal', description: 'Deals Damage to something',
                                   args: 'health:integer,target:targetType')

    CardMechanic.find_or_create_by(name: 'Destroy', description: 'Destroy something',
                                   args: 'target:targetType')

    CardMechanic.find_or_create_by(name: 'SummonCard', description: 'Deals Damage to something',
                                   args: 'cardId:integer')

    # generative / searching mechanics
    CardMechanic.find_or_create_by(name: 'Copy', description: 'Generates a copy of a target',
                                   args: 'targetType:targetType')
    # CardMechanic.find_or_create_by(name: 'Hail', description: '<strong>Find</strong> 3 cards from your deck, pick one to put on top', args: '', is_trait: true)

    # Gaining effects
    CardMechanic.find_or_create_by(name: 'GainEffect', description: 'Gain an additional effect',
                                   args: 'effect:subEffect') # subeffects are special, they're basically nested effects syntactically
    CardMechanic.find_or_create_by(name: 'GainCharge',
                                   description: 'Gives a quantity of Charge.  If Charge is not present, gives it Charge and sets it to (2, 1 + the quantity)', args: 'quantity:integer')
    CardMechanic.find_or_create_by(name: 'ReplaceEffect', description: 'Replaces the effect on this card',
                                   args: 'effect:subEffect') # subeffects are special, they're basically nested effects syntactically
  end

  # traits are commonly used keywords without args (ie: Taunt, Rush, Reborn, etc)
  def self.create_traits
    CardMechanic.find_or_create_by(name: 'Anim', description: 'Revives after being destroyed with 1 health', args: '',
                                   is_trait: true)
    CardMechanic.find_or_create_by(name: 'Bane', description: 'When this deals damage, destroy the non-player target',
                                   args: '', is_trait: true)
    CardMechanic.find_or_create_by(name: 'Bastion', description: 'Absorbs one hit of damage before disappearing',
                                   args: '', is_trait: true)
    CardMechanic.find_or_create_by(name: 'Bind', description: 'Prevents the target from acting on its next turn',
                                   args: '', is_trait: true)
    CardMechanic.find_or_create_by(name: 'Chain',
                                   description: 'An effect that occurs when this card is played after another', args: '', is_trait: true)
    CardMechanic.find_or_create_by(name: 'Fury', description: 'An effect that occurs when this minion takes damage',
                                   args: '', is_trait: true)
    CardMechanic.find_or_create_by(name: 'Inspire', description: 'Activates when the Scales are used', args: '',
                                   is_trait: true)
    CardMechanic.find_or_create_by(name: 'Link',
                                   description: 'A state shared between cards when placed between certain pieces', args: '', is_trait: true)
    CardMechanic.find_or_create_by(name: 'Mime', description: 'Can be played multiple times for the base mana cost',
                                   args: '', is_trait: true)
    CardMechanic.find_or_create_by(name: 'Rite', description: 'Complete a set of steps for a reward', args: '',
                                   is_trait: true)
    CardMechanic.find_or_create_by(name: 'Rush', description: 'Can attack enemy minions immediately', args: '',
                                   is_trait: true)
    CardMechanic.find_or_create_by(name: 'Sap', description: 'Restores health based on damage dealt', args: '',
                                   is_trait: true)
    CardMechanic.find_or_create_by(name: 'Sly', description: 'Cannot be targeted by Spells or Scale Powers', args: '',
                                   is_trait: true)
    CardMechanic.find_or_create_by(name: 'Stand', description: 'Effect occurs when this minion survives damage',
                                   args: '', is_trait: true)
    CardMechanic.find_or_create_by(name: 'Storm', description: 'Can attack any enemy character immediately', args: '',
                                   is_trait: true)
    CardMechanic.find_or_create_by(name: 'Trade', description: 'Shuffle this card into your deck and draw a new one',
                                   args: '', is_trait: true)
    CardMechanic.find_or_create_by(name: 'Veil', description: 'Cannot be targeted until this attacks', args: '',
                                   is_trait: true)
    CardMechanic.find_or_create_by(name: 'Ward', description: 'Enemy minions must attack this', args: '',
                                   is_trait: true)
      # those few Traits with args
    CardMechanic.find_or_create_by(name: 'Charge',
                                   description: 'Can be played multiple times from hand for the same cost', args: 'quantity:integer', is_trait: true)
    CardMechanic.find_or_create_by(name: 'Spell Damage', description: 'Increases damage done by Spells and Traps',
                                   args: 'spellDamageBonus:integer')
  end

  def self.create_keywords_with_args
    CardMechanic.find_or_create_by(name: 'Evoke', description: 'Summon a minion from your deck',
                                   args: 'targetType:targetType')
    CardMechanic.find_or_create_by(name: 'Find',
                                   description: 'Finds an existing card from a selection and adds it to hand', args: 'selectionSize:integer, selectionType:findSelectionType')
    CardMechanic.find_or_create_by(name: 'Form',
                                   description: 'Generates a new card from a selection and adds it to hand', args: 'selectionSize:integer, findSelectionType:findSelectionType')
    CardMechanic.find_or_create_by(name: 'Gag', description: 'Removes any/all effects from the target',
                                   args: 'targetType:targetType')
    CardMechanic.find_or_create_by(name: 'Giant', description: 'Summons powerful tokens in additional spaces',
                                   args: 'summonCount:integer')
    CardMechanic.find_or_create_by(name: 'Invoke', description: 'Activates the hero power of another card',
                                   args: 'heroCardId:integer')
    # CardMechanic.find_or_create_by(name: 'Lift',
    #                                description: 'Effect is active when a certain mana threshold is reached', args: 'manaThreshold:integer')

    CardMechanic.find_or_create_by(name: 'Raid', description: 'Able to attack multiple times per turn',
                                   args: 'quantity:integer')
    CardMechanic.find_or_create_by(name: 'Resurrect', description: 'Brings back a destroyed minion to the board',
                                   args: 'targetType:targetType')
  end
end

# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize

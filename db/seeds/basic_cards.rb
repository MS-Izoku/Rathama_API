# frozen_string_literal: true

# region: Neutral
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
# endregion


# region: Detainer ::
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
# endregion


# region: Magus ::
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
# endregion


# region: Sage ::
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
# endregion


# region: Trapper :: Eloquence
    # region: Heroes
    # endregion

    # region: Fiends
        FiendCard.create!(
        name: 'Eloquence',
        card_text: '<p><strong>Call:</strong> <strong>Form</strong> an <em>Eloquent Lie</em></p><p><strong>Rale:</strong> Summon <em>The Hungering Tongue</em></p>',
        flavor_text: '<p>Ribbit? Ribbit...</p>',
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
        # example use: <strong>Form</strong> and a Quickshot at the end of your turn.
        TrapCard.create!(
        name: 'Sand Shot',
        card_text: '<p>When an Enemy attacks, deal 1 Damage to 2 Random Enemies.</p><p>Enemies hit cannot attack this turn.</p>',
        flavor_text: '<p>Hey buddy watch this</p>',
        cost: 2,
        rarity: 'Common'
        )

        TrapCard.create!(
        name: 'Scrape Pocket',
        card_text: '<p>When your Opponent activates one of your traps, <strong>Find</strong> and cast another from your hand or deck</p>',
        flavor_text: '<p>Made you look</p>',
        cost: 2,
        rarity: 'Common'
        )

        TrapCard.create!(
        name: 'Flare Snare',
        card_text: '<p>When an enemy <strong>Call</strong> is triggered, <strong>Gag</strong> all enemy minions.</p><p>Then deal 2 damage to all enemies.</p>',
        flavor_text: '<p>Made you look</p>',
        cost: 2,
        rarity: 'Common'
        )

        TrapCard.create!(
        name: 'Spell Snare',
        card_text: '<p>When an enemy Trap or Spell targets a friendly character, summon a 1/3 Token as its target.</p>',
        flavor_text: '<p>Made you look</p>',
        cost: 2,
        rarity: 'Common'
        )

        TrapCard.create!(
        name: 'Haunting Howl',
        card_text: '<p>When a friendly Rale is activated on your Opponents turn, trigger it two more times.</p>',
        flavor_text: '<p>We heard you already</p>',
        cost: 2,
        rarity: 'Common'
        )

        TrapCard.create!(
        name: 'Avarice of Prey',
        card_text: '<p>When an enemy Trap or Spell is activated, deal its cost to the enemy Hero (max 6 damage)</p>',
        flavor_text: '<p>Hey buddy watch this</p>',
        cost: 2,
        rarity: 'Common'
        )

        TrapCard.create!(
        name: 'Quick Shot',
        card_text: '<p>Deal 2 damage to the enemy hero</p>',
        flavor_text: '<p>Hey buddy watch this</p>',
        cost: 2,
        rarity: 'Common'
        )

        TrapCard.create!(
        name: 'Stratified Pit',
        card_text: '<p>When another friendly Trap is activated, play two random Traps from your deck.</p><p>They cannot activate this turn</p>',
        flavor_text: '',
        cost: 2,
        rarity: 'Rare'
        )

        TrapCard.create!(
        name: 'Eloquent Lie: Locusta',
        card_text: '',
        flavor_text: '',
        cost: 2,
        rarity: 'Rare'
        )

        TrapCard.create!(
        name: 'Eloquent Lie: Locusta',
        card_text: '<p>When your opponent attacks with a Fiend, add a copy to your hand.</p><p>Set its Stats and Cost to (2)</p>',
        flavor_text: '',
        cost: 2,
        rarity: 'Rare'
        )

        TrapCard.create!(
        name: 'Eloquent Lie: Humano',
        card_text: '<p>When one of your Fiends die, return it to your hand.</p><p>It costs (2) less.</p>',
        flavor_text: '',
        cost: 2,
        rarity: 'Rare'
        )

        TrapCard.create!(
        name: 'Eloquent Lie: Equis',
        card_text: '<p>When your opponent attacks with a Fiend, return it to their hand.</p><p>It costs (2) more.</p>',
        flavor_text: '',
        cost: 2,
        rarity: 'Rare'
        )
        # endregion

        # region: Spells
        SpellCard.create!(
        name: 'Frog Song',
        card_text: '<p>Destroy all in-play traps.</p><p>Traps in your hand cost (0) for 2 turns</p>',
        flavor_text: '<p>Ribbit</p>',
        cost: 4,
        rarity: 'Rare'
        )
    # endregion

    # region: Weapon
    # endregion
# endregion


# region: Warden :: The Walking Festival
    # region: Heroes
    # endregion

    # region: Fiends
        FiendCard.create!(
            name: 'The Walking Festival',
            card_text: "<p><strong>Giant(4)</strong></p><p><strong>Dawn:</strong>If you control less than 4 Festival's legs, summon one.</p>",
            flavor_text: '<p>One Big Boi</p>',
            cost: 8,
            attack: 5,
            health: 10,
            rarity: 'Legendary'
        )

        FiendCard.create!(
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
# endregion

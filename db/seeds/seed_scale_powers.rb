class SeedScalePowers
  def self.seed
    # region: Sage
    ScalePower.find_or_create_by(
      name: "Sage's Scythe",
      description: '<p>Equip a 1/1 Scythe to this Scale as a weapon</p>',
      art_url: '',
      player_class: PlayerClass.find_by(name: 'Sage'),
      hero_card_id: HeroCard.find_by(name: 'Dianaria'),
      cost: 2
    )
    ScalePower.find_or_create_by(
      name: "Sage's Scythe",
      description: '<p>Equip a 1/1 Scythe to this Scale as a weapon</p>',
      art_url: '',
      player_class: PlayerClass.find_by(name: 'Sage'),
      hero_card_id: HeroCard.find_by(name: 'Dianaria'),
      cost: 2
    )
    # endregion

    # region: Trapper
    ScalePower.find_or_create_by(
      name: "Trapper's Guile",
      description: '<p><b>Form</b> a basic trap to set</p>',
      art_url: '',
      player_class: PlayerClass.find_by(name: 'Trapper'),
      hero_card_id: HeroCard.find_by(name: 'Dianaria'),
      cost: 2
    )
    ScalePower.find_or_create_by(
      name: 'Howling Arrow',
      description: '<p>Equip a 1/1 Scythe to this Scale as a weapon</p>',
      art_url: '',
      player_class: PlayerClass.find_by(name: 'Trapper'),
      hero_card_id: HeroCard.find_by(name: 'Dianaria'),
      cost: 2
    )
    # endregion

    # region: Warden
    ScalePower.find_or_create_by(
      name: "Warden's Shield",
      description: '<p>Equip a 0/1 Shield to this Scale as a weapon that absorbs 2 damage, then loses 1 durability</p>',
      art_url: '',
      player_class: PlayerClass.find_by(name: 'Sage'),
      hero_card_id: HeroCard.find_by(name: 'Dianaria'),
      cost: 2
    )

    ScalePower.find_or_create_by(
      name: "Warden's Scale",
      description: 'Gain +2 Armor',
      art_url: '',
      player_class: PlayerClass.find_by(name: 'Sage'),
      hero_card_id: HeroCard.find_by(name: 'Dianaria'),
      cost: 2
    )
    # endregion
  end
end

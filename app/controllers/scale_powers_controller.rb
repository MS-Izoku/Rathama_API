class ScalePowersController < ApplicationController
  def scale_power_creator_portal
    key = 'scale_power_creator_portal'.freeze

    if Rails.cache.exist?(key)
      @portal_data = Rails.cache.read(key)
    else
      @portal_data = {
        heroes: HeroIndexSerializer.many(HeroCard.all),
        card_types: %w[HeroCard FiendCard MonumentCard SpellCard TrapCard WeaponCard],
        rarities: Card.valid_rarities,
        mechanics: CardMechanicSerializer.many(CardMechanic.all.order(:name)),
        playerClasses: PlayerClassSerializer.many(PlayerClass.all),
        expansions: ExpansionSerializer.many(Expansion.all),
        cardTypeAttributes: {
          spellSchools: CardTypeAttributeSerializer.many(SpellSchool.all),
          tribes: CardTypeAttributeSerializer.many(Tribe.all)
        },
        enums: CardMechanic::ENUMS.merge(
          targetType: CardMechanic.target_types,
          lifecycleStage: {
            scalePower: CardMechanic.scale_power_lifecycle_stages,
            allCards: CardMechanic.all_lifecycle_stages,
            hero: CardMechanic.hero_lifecycle_stages,
            fiend: CardMechanic.fiend_lifecycle_stages,
            monument: CardMechanic.monument_lifecycle_stages,
            spell: CardMechanic.spell_lifecycle_stages,
            trap: CardMechanic.trap_lifecycle_stages,
            weapon: CardMechanic.weapon_lifecycle_stages
          }
        )
      }.as_json
      Rails.cache.write(key, @portal_data, expires_in: 12.hours)
    end

    render json: @portal_data
  end

  def show
    @scale_power = ScalePower.find_by(id: params[:id])
    render json: ScalePowerCreatorSerializer.one(@scale_power)
  end
end

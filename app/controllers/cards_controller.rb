# frozen_string_literal: true

class CardsController < ApplicationController
# region: Index Routes
  def index
    @cards = Card.all
    render json: @cards.as_json
  end

  def cards_by_expansion
    @cards = Card.where(expansion_id: params[:id])
    render json: @cards
  end

  def cards_by_type
    @cards = Card.where(type: params[:type])
    render json: @cards
  end

  def search
    # builds a collection of cards via search parameters using search_params
    @cards = Card.where(build_search_conditions)
  end
# endregion

# region General CRUD
  def show
    @card = Card.find_by(id: params[:id])
    return render json: 'Card not Found', status: :not_found unless @card

    render json: CompleteCardSerializer.one(@card)
  end

  def create
    ActiveRecord::Base.transaction do
      # Create the card without player_classes
      card_params = card_create_params.except(:player_classes, :card_mechanics)
      @card = Card.create!(card_params)

      puts "\n\n=== Initial Save Successful ===\n\n"

      # Assign PlayerClasses manually
      player_classes_data = params[:card][:player_classes] || []
      player_class_ids = player_classes_data.map { |pc| pc[:id] }
      @player_classes = PlayerClass.where(id: player_class_ids)

      @player_classes.each do |player_class|
        PlayerClassCard.create!(player_class:, card: @card)
      end

      puts "\n\n=== PlayerClassCards Created Successfully ===\n\n"

      # Assign Mechanics
      mechanics_data = params[:card][:card_mechanics] || {}

      mechanics_data.each do |lifecycle_stage, mechanics|
        mechanic_string = CardMechanicAssignment.create_adjusted_mechanic_string(lifecycle_stage, mechanics)
        puts 'Mechanic String => ' + mechanic_string
        CardMechanicAssignment.create!(
          card: @card,
          as_string: mechanics.join('|'), # Store raw mechanics list
          lifecycle_stage:,
          mechanic_string: # Store formatted mechanics string
        )
      end

      puts "\n\n=== CardMechanicAssignments Created Successfully ===\n\n"

      render json: @card, status: :created
    end
  rescue ActiveRecord::RecordInvalid => e
    puts "Transaction failed: #{e.message}"
    @card&.destroy # Ensures cleanup if the card was partially created
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  def update
    @card = Card.find_by(id: card_update_params[:id])
    @card.assign_attributes(card_update_params)
    @card.save

    if @card.errors
      render_error(@card, @card.error)
    else
      render json: @card
    end
  end

  def destroy
    @card = Card.find_by(id: card_update_params[:id])
    @card.assign_attributes(card_update_params)
    if @card.save
      render json: @card
    else
      render_error(@card, @card.error)
    end
  end
# endregion

  def change_image; end

  def add_variant_image; end

# region Specific Card Types
  def spells
    if Rails.cache.exist?('spells')
      @spells = Rails.cache.read('spells')
    else
      @spells = SpellCard.all.to_a
      Rails.cache.write('spells', @spells, expires_in: 12.hours)
    end
    render json: { spells: SpellSerializer.many(@spells) }
  end

  def traps
    if Rails.cache.exist?('traps')
      @traps = Rails.cache.read('traps')
    else
      @traps = TrapCard.all.to_a
      Rails.cache.write('traps', @traps, expires_in: 12.hours)
    end

    render json: { traps: TrapSerializer.many(@traps) }
  end

  def weapons
    if Rails.cache.exist?('weapons')
      @weapons = Rails.cache.read('weapons')
    else
      @weapons = WeaponCard.all.to_a
      Rails.cache.write('weapons', @weapons, expires_in: 12.hours)
    end

    render json: { weapons: WeaponSerializer.many(@weapons) }
  end

  def monuments
    if Rails.cache.exist?('monuments')
      @monuments = Rails.cache.read('monuments')
    else
      @monuments = MonumentCard.all.to_a
      Rails.cache.write('monuments', @monuments, expires_in: 12.hours)
    end

    render json: { monuments: MonumentSerializer.many(@monuments) }
  end

  def fiends
    if Rails.cache.exist?('fiends')
      @fiends = Rails.cache.read('fiends')
    else
      @fiends = FiendCard.all.to_a
      Rails.cache.write('fiends', @fiends, expires_in: 12.hours)
    end

    render json: { fiends: FiendSerializer.many(@fiends) }
  end

  def heroes
    if Rails.cache.exist?('heroes')
      @heroes = Rails.cache.read('heroes')
    else
      @heroes = HeroCard.all.to_a
      Rails.cache.write('heroes', @heroes, expires_in: 12.hours)
    end

    render json: { heroes: HeroSerializer.many(@heroes) }
  end

# endregion

# region Lookup By Expansion

  def cards_from_expansion
    @expansion = Expansion.find_by(id: params[:expansion_id])
    return render json: { error: "Expansion not found with Id: #{params[:expansion_id]}" } unless @expansion

    key = "#{@expansion.slug_name}_cards"

    if Rails.cache.exist?(key)
      @cards_hash = Rails.cache.read(key)
    else
      cards = Card.where(expansion_id: @expansion.id)

      @card_hash = {
        fiends: FiendSerializer.many(cards.select { |card| card.type == 'FiendCard' }),
        heroes: HeroSerializer.many(cards.select { |card| card.type == 'HeroCard' }),
        momuments: MonumentSerializer.many(cards.select { |card| card.type == 'MonumentCard' }),
        spells: SpellSerializer.many(cards.select { |card| card.type == 'SpellCard' }),
        traps: TrapSerializer.many(cards.select { |card| card.type == 'TrapCard' }),
        weapons: WeaponSerializer.many(cards.select { |card| card.type == 'WeaponCard' })
      }

      Rails.cache.write(key, @card_hash, expires_in: 12.hours)
    end

    render json: @card_hash
  end

  def spells_from_expansion
    @expansion = Expansion.find_by(id: params[:expansion_id])
    return render json: { error: "Expansion not found with Id: #{params[:expansion_id]}" } unless @expansion

    key = "#{@expansion.slug_name}_spells"

    if Rails.cache.exist?(key)
      @spells = Rails.cache.read(key)
    else
      @spells = SpellCard.where(expansion_id: @expansion.id).to_a
      Rails.cache.write(key, @spells, expires_in: 12.hours)
    end
    render json: SpellSerializer.many(@spells)
  end

  def traps_from_expansion
    @expansion = Expansion.find_by(id: params[:expansion_id])
    return render json: { error: "Expansion not found with Id: #{params[:expansion_id]}" } unless @expansion

    key = "#{@expansion.slug_name}_traps"

    if Rails.cache.exist?(key)
      @traps = Rails.cache.read(key)
    else
      @traps = TrapCard.all.to_a
      Rails.cache.write(key, @traps, expires_in: 12.hours)
    end

    render json: @traps
  end

  def weapons_from_expansion
    @expansion = Expansion.find_by(id: params[:expansion_id])
    return render json: { error: "Expansion not found with Id: #{params[:expansion_id]}" } unless @expansion

    key = "#{@expansion.slug_name}_weapons"

    if Rails.cache.exist?(key)
      @weapons = Rails.cache.read(key)
    else
      @weapons = WeaponCard.all.to_a
      Rails.cache.write(key, @weapons, expires_in: 12.hours)
    end

    render json: WeaponSerializer.many(@weapons)
  end

  def monuments_from_expansion
    @expansion = Expansion.find_by(id: params[:expansion_id])
    return render json: { error: "Expansion not found with Id: #{params[:expansion_id]}" } unless @expansion

    key = "#{@expansion.slug_name}_monuments"

    if Rails.cache.exist?(key)
      @monuments = Rails.cache.read(key)
    else
      @monuments = MonumentCard.all.to_a
      Rails.cache.write(key, @monuments, expires_in: 12.hours)
    end

    render json: MonumentSerializer.many(@monuments)
  end

  def fiends_from_expansion
    @expansion = Expansion.find_by(id: params[:expansion_id])
    return render json: { error: "Expansion not found with Id: #{params[:expansion_id]}" } unless @expansion

    key = "#{@expansion.slug_name}_fiends"

    if Rails.cache.exist?(key)
      @fiends = Rails.cache.read(key)
    else
      @fiends = FiendCard.all.to_a
      Rails.cache.write(key, @fiends, expires_in: 12.hours)
    end

    render json: FiendSerializer.many(@fiends)
  end

  def heroes_from_expansion
    @expansion = Expansion.find_by(id: params[:expansion_id])
    return render json: { error: "Expansion not found with Id: #{params[:expansion_id]}" } unless @expansion

    key = "#{@expansion.slug_name}_heroes"

    if Rails.cache.exist?(key)
      @heroes = Rails.cache.read(key)
    else
      @heroes = HeroCard.all.to_a
      Rails.cache.write(key, @heroes, expires_in: 12.hours)
    end

    render json: HeroSerializer.many(@heroes)
  end

# endregion

# region Card Creator Portal
  def card_creator_inputs
    render json: {
      card_types: %(HeroCard, FiendCard, MonumentCard, SpellCard, TrapCard, WeaponCard),
      rarities: Card.valid_rarities,
      mechanics: CardMechanicSerializer.many(CardMechanic.all.order(:name)),
      playerClasses: PlayerClassSerializer.many(PlayerClass.all),
      expansions: ExpansionSerializer.many(Expansion.all),
      enums: CardMechanic::ENUMS.merge(
        targetType: CardMechanic.target_types,
        lifecycleStage: {
          all: CardMechanic.all_lifecycle_stages,
          hero: CardMechanic.hero_lifecycle_stages,
          fiend: CardMechanic.fiend_lifecycle_stages,
          monument: CardMechanic.monument_lifecycle_stages,
          spell: CardMechanic.spell_lifecycle_stages,
          trap: CardMechanic.trap_lifecycle_stages,
          weapon: CardMechanic.weapon_lifecycle_stages
        }
      )

    }
  end
# endregion

  private

# region: Strong Params
  def card_create_params
    params.require(:card).permit(
      :id, :type, :name, :cost, :rarity, :card_text, :flavor_text,
      :is_generated_card, :deck_size_modifier_type, :deck_size_modifier_value,
      :attack, :health, :armor, :durability, :expansion_id,
      # :image_file,
      player_classes: %i[id name], # Allow player_classes as an array of objects with specific keys
      card_mechanics: {} # Allow card_mechanics as a hash
    )
  end

  def card_update_params
    params.require(:card).permit(:id, :name, :expansion_id, :attack, :health, :armor, :durability)
  end

  def card_destroy_params
    params.require(:card).permit(:id)
  end

  def search_params
    params.permit(:name, :card_text, :cost, :flavor_text, :rarity, :type, :attack, :health, :armor, :durability,
                  :expansion_id)
  end

# endregion

  def build_search_conditions
    conditions = {}

    # conditionally add the formatted key-values to the conditions hash to return
    search_params.each do |key, value|
      if key == :type
        conditions[:type] = value
      else
        # generic lookup method
        conditions[key] = if value.present?
                            key.to_s.ends_with?('_id') ? value.to_i : "%#{value}%"
                          end
      end
    end

    conditions
  end
end

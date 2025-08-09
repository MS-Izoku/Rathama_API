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

  # def create
  #   ActiveRecord::Base.transaction do
  #     # Create the card without player_classes
  #     card_params = card_create_params.except(:player_classes, :card_mechanics, :card_type_attributes)
  #     @card = Card.create!(card_params)

  #     # Assign PlayerClasses manually
  #     player_classes_data = params[:card][:player_classes] || []
  #     player_class_ids = player_classes_data.map { |pc| pc[:id] }
  #     @player_classes = PlayerClass.where(id: player_class_ids)

  #     @player_classes.each do |player_class|
  #       PlayerClassCard.create!(player_class:, card: @card)
  #     end

  #     # Assign Mechanics
  #     mechanics_data = params[:card][:card_mechanics] || {}

  #     mechanics_data.each do |lifecycle_stage, mechanics|
  #       mechanic_string = CardMechanicAssignment.create_adjusted_mechanic_string(lifecycle_stage, mechanics)
  #       CardMechanicAssignment.create!(
  #         card: @card,
  #         as_string: mechanics.join('|'), # Store raw mechanics list
  #         lifecycle_stage:,
  #         mechanic_string: # Store formatted mechanics string
  #       )
  #     end

  #     # asscociate CardTypeAttributes

  #     attributes_data = params[:card][:card_type_attributes] || []
  #     attr_type = if @card.type == 'FiendCard'
  #                   'Tribe'
  #                 elsif @card.type == 'SpellCard' || @card.type == 'TrapCard'
  #                   'SpellSchool'
  #                 end

  #     attributes_data.each do |attr|
  #     # binding.break
  #       puts "--- Doing Attribute Stuff --- #{attr}"
  #       CardType.create!(card: @card, card_type_attribute_id: attr['id'])
  #     end

  #     render json: @card, status: :created
  #   end
  # rescue ActiveRecord::RecordInvalid => e
  #   puts "Transaction failed: #{e.message}"
  #   @card&.destroy # Ensures cleanup if the card was partially created
  #   render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  # end

  def create
    @attachments_succeeded = false
    @upload_token = SecureRandom.uuid # Generate a unique upload token to tag blobs in a future image upload request
    card_params = card_create_params.except(:player_classes, :card_mechanics, :card_type_attributes)
    @created_blobs = []

    ActiveRecord::Base.transaction do
      # Create the card without player_classes
      @card = Card.create!(card_params.merge(upload_token: @upload_token))

      # Assign PlayerClasses manually
      puts '================ Handling PlayerClasses ================='
      # binding.break
      player_classes_data = params[:card][:player_classes] || []
      player_class_ids = player_classes_data.map { |pc| pc[:id].to_i } # force integer
      @player_classes = PlayerClass.where(id: player_class_ids)
      @player_classes.each do |player_class|
        PlayerClassCard.create!(player_class:, card: @card)
      end

      # Assign Mechanics
      puts '================ Handling Mechanics ================='
      mechanics_data = params[:card][:card_mechanics] || {}
      mechanics_data.each do |lifecycle_stage, mechanics|
        mechanic_string = CardMechanicAssignment.create_adjusted_mechanic_string(lifecycle_stage, mechanics)
        CardMechanicAssignment.create!(
          card: @card,
          as_string: mechanics.join('|'),
          lifecycle_stage:,
          mechanic_string:
        )
      end

      # Associate CardTypeAttributes
      puts '================ Handling CardTypeAttributes ================='
      attributes_data = params[:card][:card_type_attributes] || []
      attributes_data.each do |_index, attribute|
        # binding.break
        CardType.create!(card: @card, card_type_attribute_id: attribute['id'].to_i)
      end
      puts '================ Completed CardTypeAttributes ================='

      puts '================ Handling Card Image (whole) ================='
      if params[:card][:card_img].present?
        blob = ActiveStorage::Blob.create_and_upload!(
          io: params[:card][:card_img],
          filename: params[:card][:card_img].original_filename,
          content_type: params[:card][:card_img].content_type,
          metadata: { upload_token: @upload_token, image_type: 'card_img' }
        )
        img_key = blob.key
        # binding.break
        puts '============================'
        puts blob.key
        puts '============================'
        @created_blobs << blob
        @card.card_img.attach(blob)
      end

      puts '================ Handling Card Image (Art Only) ================='
      if params[:card][:card_art_img].present?
        blob = ActiveStorage::Blob.create_and_upload!(
          io: params[:card][:card_art_img],
          filename: params[:card][:card_art_img].original_filename,
          content_type: params[:card][:card_art_img].content_type,
          metadata: { upload_token: @upload_token, image_type: 'card_art_img' }
        )

        # binding.break
        card_img_key = blob.key
        puts '============================'
        puts blob.key
        puts '============================'
        @created_blobs << blob
        @card.card_art_img.attach(blob)
      end

      puts "Keys:\n#{img_key}\n#{card_img_key}"

      @attachments_succeeded = true

      # Respond with both the created card and the upload token
      render json: { card: @card, upload_token: @upload_token }, status: :created
    end
  rescue StandardError => e
    puts "Transaction failed: #{e.message}"
    # binding.break
    @card&.destroy unless @attachments_succeeded

    # Clean up orphaned blobs if attachments were attempted but creation failed
    unless @attachments_succeeded
      orphaned_blobs = ActiveStorage::Blob.where("metadata::jsonb ->> 'upload_token' = ?", @upload_token)

      orphaned_blobs.each(&:purge_later)
    end

    render json: { errors: e }, status: :unprocessable_entity
  end

  def update
    ActiveRecord::Base.transaction do
      @card = Card.find_by(id: card_create_params[:id])
      return render json: { error: 'Card not found' }, status: :not_found unless @card

      # Update basic card fields
      card_params = card_create_params.except(:player_classes, :card_mechanics)
      @card.update!(card_params)

      # Manage PlayerClasses
      incoming_player_class_ids = (params[:card][:player_classes] || []).pluck(:id)
      existing_player_class_ids = @card.player_classes.pluck(:id)

      # Remove old relationships
      removed_ids = existing_player_class_ids - incoming_player_class_ids
      PlayerClassCard.where(card: @card, player_class_id: removed_ids).destroy_all

      # Add new relationships
      new_ids = incoming_player_class_ids - existing_player_class_ids
      new_ids.each { |pc_id| PlayerClassCard.create!(player_class_id: pc_id, card: @card) }

      # Manage Mechanics
      incoming_mechanics = params[:card][:card_mechanics] || {}
      existing_mechanics = @card.card_mechanic_assignments.index_by(&:lifecycle_stage)

      # Update or remove existing mechanics
      existing_mechanics.each do |lifecycle_stage, assignment|
        # binding.break
        if incoming_mechanics.key?(lifecycle_stage)
          # Update mechanic
          assignment.update!(
            as_string: incoming_mechanics[lifecycle_stage].join('|'),
            mechanic_string: CardMechanicAssignment.create_adjusted_mechanic_string(lifecycle_stage,
                                                                                    incoming_mechanics[lifecycle_stage])
          )
        else
          # Remove mechanic if it's not in the request
          assignment.destroy!
        end
      end

      # Add new mechanics
      (incoming_mechanics.keys - existing_mechanics.keys).each do |lifecycle_stage|
        CardMechanicAssignment.create!(
          card: @card,
          lifecycle_stage:,
          as_string: incoming_mechanics[lifecycle_stage].join('|'),
          mechanic_string: CardMechanicAssignment.create_adjusted_mechanic_string(lifecycle_stage,
                                                                                  incoming_mechanics[lifecycle_stage])
        )
      end

      render json: @card, status: :ok
    end
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "Update failed: #{e.message}"
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
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
      cardTypeAttributes: {
        spellSchools: CardTypeAttributeSerializer.many(SpellSchool.all),
        tribes: CardTypeAttributeSerializer.many(Tribe.all)
      },
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
    # this allows for blank-array bodies of mechanics (for non-mechanic/true-vanilla cards)
    if params[:card][:card_mechanics].is_a?(Array) && params[:card][:card_mechanics].empty?
      params[:card][:card_mechanics] = {}
    end

    params.require(:card).permit(
      :id, :type, :name, :cost, :rarity, :card_text, :flavor_text,
      :is_generated_card, :deck_size_modifier_type, :deck_size_modifier_value,
      :attack, :health, :armor, :durability, :expansion_id,
      :card_img, # the card art used for this card
      player_classes: %i[id name],  # Allow player_classes as an array of objects with specific keys
      card_mechanics: {},           # Allow card_mechanics as a hash,
      card_type_attributes: %i[id name description]
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

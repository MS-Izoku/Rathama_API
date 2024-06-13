class CardsController < ApplicationController
  

# region: Index Routes
  def index
    @cards = Card.all
    render json: @cards
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
    render json: @card
  end

  def create
    @card = Card.new(card_create_params)
    if @card.save
      render json: @card
    else
      render_error(@card, @card.error)
    end
  end

  def update
    @card = Card.find_by(id: card_update_params[:id])
    @card.assign_attributes(card_update_params)
    if @card.save
      render json: @card
    else
      render_error(@card, @card.error)
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


  def change_image
  end


  def add_variant_image
  end

# region Specific Card Types
  def spells
    if Rails.cache.exist?('spells')
      @spells = Rails.cache.read('spells')
    else
      @spells = SpellCard.all.to_a
      Rails.cache.write('spells', @spells, expires_in: 12.hours)
    end
    render json: SpellSerializer.many(@spells)
  end

  def traps
    if Rails.cache.exist?("traps")
      @traps = Rails.cache.read("traps")
    else     
      @traps = TrapCard.all.to_a
      Rails.cache.write("traps", @traps, expires_in: 12.hours)
    end

    render json: @traps
  end

  def weapons
    @weapons = WeaponCard.all
    render json: @weapons
  end

  def monuments
    if Rails.cache.exist?("monuments")
      @monuments = Rails.cache.read("monuments")
    else
      @monuments = MonumentCard.all.to_a
      Rails.cache.write("monuments", @monuments, expires_in: 12.hours)
    end

    render json: MonumentSerializer.many(@monuments)
  end

  def fiends
    if Rails.cache.exist?("fiends")
      @fiends = Rails.cache.read("fiends")
    else     
      @fiends = FiendCard.all.to_a
      Rails.cache.write("fiends", @fiends, expires_in: 12.hours)
    end

    render json: FiendSerializer.many(@fiends)
  end
# endregion


private

# region: Strong Params
  def card_create_params
    params.require(:card).permit(:id, :type, :attack, :health, :armor, :durability, :expansion_id)
  end

  def card_update_params
    params.require(:card).permit(:id, :name, :expansion_id, :attack, :health, :armor, :durability)
  end

  def card_destroy_params
    params.require(:card).permit(:id)
  end

  def search_params
    params.permit(:name, :card_text, :cost, :flavor_text, :rarity, :card_art_url, :type, :attack, :health, :armor, :durability, :expansion_id)
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
        conditions[key] = value.present? ? key.to_s.ends_with?('_id') ? value.to_i : "%#{value}%" : nil
      end
    end

    conditions
  end
end

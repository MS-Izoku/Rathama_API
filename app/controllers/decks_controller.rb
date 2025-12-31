# frozen_string_literal: true

class DecksController < ApplicationController
  # before_action :authenticate_user # @current_user is available

  def index
    @decks = Deck.where(owner_id: current_user.id)
    render json: @decks
  end

  def deck_codes_index
    @decks = Deck.where(owner_id: current_user.id)
    render json: @decks
  end

  def show
    @deck = Deck.find_by(id: params[:id])
    render json: { deck_code: @deck.deck_code, name: @deck.name, description: @deck.description }
  end

  def create
    unless deck_params[:deck_classes]&.any?
      return render json: { error: 'At least one valid player class is required' }, status: :bad_request
    end

    @deck = nil
    ActiveRecord::Base.transaction do
      # Create deck
      @deck = Deck.create_deck_from_params(deck_params, deck_params[:owner_id])

      # Validate and create deck classes
      valid_player_classes = deck_params[:deck_classes].reject { |class_name| class_name == 'Neutral' }
      valid_player_classes.each do |dc_name|
        player_class = PlayerClass.find_by(name: dc_name)
        unless player_class
          @deck.errors.add(:deck_classes, "Invalid player class: #{dc_name}")
          raise ActiveRecord::Rollback
        end
        DeckClass.create!(player_class:, deck: @deck)
      end

      # Validate deck after creating cards and classes
      raise ActiveRecord::Rollback if @deck.errors.any? || !@deck.valid?
    rescue ActiveRecord::Rollback
      # Errors will be handled below
      nil
    rescue StandardError => e
      Rails.logger.error("Unexpected error in deck creation: #{e.message}")
      render json: { error: 'An unexpected error occurred' }, status: :internal_server_error
      return
    end

    if @deck&.errors&.any?
      render json: { errors: @deck.errors.full_messages }, status: :bad_request
    elsif @deck
      # Cache the deck (assuming deck_key is defined)
      Rails.cache.write(deck_key(@deck), @deck, expires_in: 12.hours)
      render json: {
        deck: DeckSerializer.one(@deck),
        card_count: @deck.deck_cards.count,
        deck_classes: @deck.deck_classes.map { |dc| dc.player_class.name }
      }, status: :created
    else
      render json: { error: 'Deck creation failed' }, status: :bad_request
    end
  end

  def update
    # data modification
    ActiveRecord::Base.transaction do
      @deck = deck.find_by(id: deck_update_[:deck_id])

      @deck.name = deck_params[:name] if deck_params[:name] != @deck.name
      @deck.description = deck_params[:description] if deck_params[:description] != @deck.description

      Deck.update_card_list(deck, deck_params[:card_ids])

      if @deck.errors.any?
        p @deck.errors
        raise ActiveRecord::Rollback
      end
    rescue StandardError
      raise ActiveRecord::Rollback
    end

    # json rendering
    if @deck.errors.any?
      render json: { errors: @deck.errors }, status: :bad_request
    else
      Rails.cache.write(deck_key(@deck), @deck, expires_in: 12.hours)
      render json: { deck: @deck, card_count: @deck.deck_cards.count }
    end
  end

  def destroy
    @deck = Deck.find_by(id: deck_delete_params[:id])
    return render json: { error: 'Deck not Found' }, status: :not_found if deck.nil?

    if @current_user.id != @deck.owner_id
      return render json: { error: 'Deck does not belong to user' },
                    status: :unauthorized
    end

    ActiveRecord::Base.transaction do
      @deck.destroy
      raise ActiveRecord::Rollback if @deck.errors.any?
    rescue StandardError
      raise ActiveRecord::Rollback
    end

    if @deck.errors.any?
      render json: { errors: @deck.errors }, status: :bad_request
    else
      Rails.cache.delete(deck_key(@deck))
      render json: { deck: @deck, card_count: @deck.deck_cards.count }
    end
  end

  private

  def deck_params
    params.require(:deck).permit(:id, :name, :description, :owner_id, card_ids: [], deck_classes: [])
  end

  def deck_update_params
    params.require(:deck).permit(:id, :name, :description, card_ids: [])
  end

  def deck_delete_params
    params.require(:deck).permit(:id)
  end

  def deck_key(deck)
    "deck_#{deck.id}_#{deck.user.id}"
  end
end

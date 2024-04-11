class DecksController < ApplicationController
  before_action :authenticate_user # assuming you have authentication set up

  def index; end

  def show; end

  def create
    # data transaction
    ActiveRecord::Base.transaction do
      @deck = Deck.create_deck_from_params(deck_params, current_user.id)

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
      render json: { deck: @deck, card_count: @deck.deck_cards.count }
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
      render json: { deck: @deck, card_count: @deck.deck_cards.count }
    end
  end


  def destroy
  end

  private

  def deck_params
    params.require(:deck).permit(:id, :name, :description, :owner_id, card_ids: [])
  end

  def deck_update_params
    params.require(:deck).permit(:id, :name, :description, card_ids: [])
  end

  def deck_delete_params
    params.require(:deck).permit(:id)
  end
end

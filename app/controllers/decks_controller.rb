class DecksController < ApplicationController
  # before_action :authenticate_user! # assuming you have authentication set up

  def index; end

  def show; end

  def create
    p 'Starting Deck Creation'

    return render json: { errors: ['User not Found'] } if User.find_by(id: deck_params[:owner_id]).nil?

    ActiveRecord::Base.transaction do
      @deck = Deck.create_deck_from_params(deck_params)
      if @deck.errors.any?
        p @deck.errors
        raise ActiveRecord::Rollback 
      end
    rescue
      raise ActiveRecord::Rollback
    end

    if @deck.errors.any?
      render json: { errors: @deck.errors }, status: :bad_request
    else
      render json: @deck
    end
  end

  def update
    # deck = Deck.find_by(id: deck_params[:id])
    # deck.update(name: deck_params[:name], description: deck_params[:description])

    # cards_in_deck = Card.where(id: card_ids)

    # if deck.errors.any?
    #   render json: render_error(deck, 'Failed to Save new Deck')
    # else
    #   render json: deck
    # end

    ActiveRecord::Base.transaction do
      @deck = Deck.find_by(id: deck_update_params[:id])
      DeckCard.where(deck_id: @deck.id).destroy_all

      Deck.create_deck_cards(@deck, card_list)

      raise ActiveRecord::Rollback if @deck.errors.any?
    rescue StandardError
      raise ActiveRecord::Rollback
    end

    if @deck.errors.any?
      render json: { errors: @deck.errors['base'] }, status: :bad_request
    else
      render json: @deck
    end
  end

  def destroy
    deck = Deck.find(params[:id])
    # Check if the deck belongs to the current user
    if deck.user_id == current_user.id
      deck.destroy
      render json: { message: 'Deck deleted successfully' }, status: :ok
    else
      render json: { error: 'You are not authorized to delete this deck' }, status: :unauthorized
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Deck not found' }, status: :not_found
  end

  private

  def deck_params
    params.require(:deck).permit(:id, :name, :description, :owner_id, card_ids: [])
  end

  def deck_update_params
    params.require(:deck).permit(:name, :description, card_ids: [])
  end

  def deck_delete_params
    params.require(:deck).permit(:id, :user_id)
  end
end

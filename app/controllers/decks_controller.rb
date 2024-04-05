class DecksController < ApplicationController
  #before_action :authenticate_user! # assuming you have authentication set up
  
  def index
  end

  def show
  end

  def create
    deck = Deck.create(name: deck_params[:name], description: deck_params[:description], owner_id: deck_params[:owner_id])
    p deck_params[:card_ids]
    deck_params[:card_ids].each do |card_id|
      DeckCard.create(deck_id: deck.id, card_id: card_id)
    end

    unless deck.errors.any?
      render json: deck
    else
      render json: render_error(deck, "Failed to Save new Deck")
    end
  end


  def update
    deck = Deck.find_by(id: deck_params[:id])
    deck.update(name: deck_params[:name], description: deck_params[:description])

    cards_in_deck = Card.where(id: card_ids)
    # compare cards_in_deck vs cards already in the deck (deck.cards)
    # remove deck.cards that are not already in cards_in_deck
    # add cards not already in the deck

    unless deck.errors.any?
      render json: deck
    else
      render json: render_error(deck, "Failed to Save new Deck")
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

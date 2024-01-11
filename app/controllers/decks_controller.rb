class DecksController < ApplicationController
  def index
  end

  def show
  end

  def create
    deck = Deck.create(deck_parms)
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
    deck = Deck.find_by(id: deck_delete_params[:id])

  end


  private
  def deck_params
    params.require(:deck).permit(:id, :name, :description, card_ids: [])
  end
  

  def deck_update_params
    params.require(:deck).permit(:name, :description, card_ids: [])
  end

  def deck_delete_params
    params.require(:deck).permit(:id)
  end
end

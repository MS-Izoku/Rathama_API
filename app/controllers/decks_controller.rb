class DecksController < ApplicationController
  before_action :authenticate_user # assuming you have authentication set up

  def index; end

  def show; end

  def create   
    ActiveRecord::Base.transaction do
      @deck = Deck.create_deck_from_params(deck_params, current_user.id)

      if @deck.errors.any?
        p @deck.errors
        raise ActiveRecord::Rollback
      end
    rescue StandardError
      raise ActiveRecord::Rollback
    end

    if @deck.errors.any?
      render json: { errors: @deck.errors }, status: :bad_request
    else
      render json: { deck: @deck, card_count: @deck.deck_cards.count }
    end
  end

  def update
    user = User.find_by(id: deck_params[:owner_id])
    return render json: { errors: ['User not Found'] } if user.nil?

    ActiveRecord::Base.transaction do
      @deck = Deck.find_by(id: deck_update_params[:id])
      if @deck.owner_id != user.id
        return render json: { errors: ['Not Authorized to modify this deck'] }, status: :unauthorized
      end

      deck.assign_attributes(deck_update_params.except(:card_ids))

      Deck.update_card_list(deck, deck_update_params[:card_ids])

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
  end

  private

  def deck_params
    params.require(:deck).permit(:id, :name, :description, :owner_id, card_ids: [])
  end

  def deck_update_params
    params.require(:deck).permit(:name, :description, card_ids: [])
  end

  def deck_delete_params
    params.require(:deck).permit(:id)
  end
end

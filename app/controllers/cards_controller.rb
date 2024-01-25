class CardsController < ApplicationController
  def index
    @cards = Card.all
  end

  def show
  end

  def create
  end

  def update
  end

  def destroy
  end

  def change_image
  end

  def add_variant_image
  end

# region Specific Card Types
  def spells
    @spells = Spell.all
    render json: @spells
  end

  def traps
    @traps = Trap.all
    render json: @traps
  end

  def weapons
    @weapons = Weapon.all
    render json: @weapons
  end

  def monuments
    @monuments = Monument.all
    render json: @monuments
  end

  def fiends
    @fiends = Fiend.all
    render json: @fiends
  end
# endregion
end

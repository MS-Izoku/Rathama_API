# frozen_string_literal: true

class CardPack < ApplicationRecord
  has_many :player_card_packs
  has_many :players, through: :player_card_packs
end

# frozen_string_literal: true

class PlayerClassCard < ApplicationRecord
  belongs_to :player_class
  belongs_to :card
end

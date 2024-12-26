# frozen_string_literal: true

class DeckClass < ApplicationRecord
  belongs_to :deck
  belongs_to :player_class

  def as_json(_options = {})
    super(only: [:id], include: { deck: { only: %i[id name] }, player_class: { only: %i[id name] } })
  end
end

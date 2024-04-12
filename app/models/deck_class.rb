class DeckClass < ApplicationRecord
    belongs_to :deck
    belongs_to :player_class

    def as_json(options = {})
        super(only: [:id], include: { deck: { only: [:id, :name] }, player_class: {only: [:id, :name]} })
    end
end

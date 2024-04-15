class PlayerCardPack < ApplicationRecord
    self.primary_key = 'id'
    attribute :id, :uuid, default: -> { "gen_random_uuid()" }

    belongs_to :user
    belongs_to :card_pack
end

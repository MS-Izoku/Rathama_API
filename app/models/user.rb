class User < ApplicationRecord
    has_secure_password
    has_many :decks, foreign_key: "owner_id"

    has_many :cards

    # the general  "Collection" of a user is their owned cards
    def collection
        cards
    end
end

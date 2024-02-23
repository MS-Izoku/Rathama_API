class User < ApplicationRecord
    has_secure_password
    has_many :api_keys, as: :owner 
    has_many :decks, foreign_key: "owner_id"

    has_many :cards

    # the general  "Collection" of a user is their owned cards
    def collection
        cards
    end

    def deactivate_api_keys
        api_key_model = ApiKey.where(owner_id: self.id)

        unless api_key_model.nil?
            save
        end
        nil
    end
end

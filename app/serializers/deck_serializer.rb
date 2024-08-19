class DeckSerializer < Oj::Serializer
    attributes :name, :description, :owner_id, :deck_code, :is_playable
end
class CardSerializer < Oj::Serializer
    attributes :name, :cost, :card_text, :flavor_text, :rarity, :expansion_id, :card_art_url
end
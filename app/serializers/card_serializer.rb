class CardSerializer < Oj::Serializer
    attributes :name, :cost, :card_text, :flavor_text, :rarity, :expansion_id, :card_art_url
end

class HeroSerializer < CardSerializer
    attributes :armor
end



class TrapSerializer < CardSerializer
    has_many :spell_schools, serializer: CardTypeAttributeSerializer
end

class WeaponSerializer < CardSerializer
    attributes :durability, :attack
end

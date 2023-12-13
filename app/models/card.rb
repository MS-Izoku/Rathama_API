class Card < ApplicationRecord
    # presence checks
    validates :name, :card_text, :cost, :flavor_text, :rarity, :card_art_url, presence: true
    
    # uniqueness checks
    validates :name, uniqueness: true
    validates :card_art_url, uniqueness: true
    validates :flavor_text, uniqueness: true

# region: Card Type Checks
    def fiend_card?
        self.type == 'FiendCard'
    end
    
    def spell_card?
        self.type == 'SpellCard'
    end

    def trap_card?
        self.type == 'TrapCard'
    end
    
    def weapon_card?
        self.type == 'WeaponCard'
    end

    def monument_card?
        self.type == 'MonumentCard'
    end
    
    def hero_card?
        self.type == 'HeroCard'
    end
# endregion

private

end


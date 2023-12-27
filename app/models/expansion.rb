class Expansion < ApplicationRecord
  belongs_to :expansion_group
  has_many :cards

# region: Cards By Type

  def fiends(tribe)
    tribe = tribe.name if tribe.class == "Tribe"

    if tribe
      cards.joins(:card_type_attribute).where(type: 'FiendCard', card_type_attributes: { type: 'Tribe', name: tribe })
    else
      card.where(type: "FiendCard")
    end
  end
  

  def heroes
    cards.where(type: 'HeroCard')
  end
  

  def monuments
    cards.where(type: 'MonumentCard')
  end


  def spells(spell_school)
    spell_school = spell_school.name if spell_school.class == "SpellSchool"

    if spell_school
      cards.joins(:card_type_attribute).where(type: 'SpellCard', card_type_attributes: { type: 'SpellSchool', name: spell_school })
    else
      card.where(type: "SpellCard")
    end
  end


  def traps(spell_school)
    spell_school = spell_school.name if spell_school.class == "SpellSchool"

    if spell_school
      cards.joins(:card_type_attribute).where(type: 'TrapCard', card_type_attributes: { type: 'SpellSchool', name: spell_school })
    else
        card.where(type: "TrapCard")
    end
  end


  def weapons
    cards.where(type: 'WeaponCard')
  end
  
# endregion


end

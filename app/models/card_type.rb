# frozen_string_literal: true

class CardType < ApplicationRecord
  belongs_to :card, dependency: :destroy
  belongs_to :card_type_attribute, dependency: :destroy
  validate :validate_card_attribute

  private

    # validates the card_type_attribute to ensure that it matches the proper type of card
  def validate_card_attribute
    case card.type
    when 'FiendCard'
      if card_type_attribute.type != 'Tribe'
        errors.add(:base,
                   'Cannot create connection of non-Tribe Attribute to Fiend')
      end
    when 'HeroCard'
      errors.add(:base, 'Cannot connect attribute to Hero Card') if card_type_attribute
    when 'MonumentCard'
      errors.add(:base, 'Cannot connect attribute to Monument Card') if card_type_attribute
    when 'SpellCard'
      errors.add(:base, 'Cannot connect attribute to Hero Card') if card_type_attribute.type != 'SpellSchool'
    when 'TrapCard'
      errors.add(:base, 'Cannot connect attribute to Hero Card') if card_type_attribute.type != 'SpellSchool'
    when 'WeaponCard'
      errors.add(:base, 'Cannot connect attribute to Weapon Card') if card_type_attribute
    else
      break
    end
  end
end

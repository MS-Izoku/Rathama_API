class CardAttribute < ApplicationRecord
  # A joiner class between Cards and Tribes/Spell Schools
  # Never use a CardTypeAttribute directly, always a child-type of the class
  belongs_to :card, dependency: :destroy
  belongs_to :card_type_attribute, dependency: :destroy

  validate :card_type_attribute_type # how do I validate the pressence of the "type" field here, which is a string on the :card_type_attribute model?

  def validate_card_attribute_type
    errors.add(:base, "CardTypeAttribute is nil, use Tribe or SpellSchool instead")if card_type_attribute.type.nil?
  end
end

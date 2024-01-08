# A root class used in a simple STI relationship with Tribes and SpellSchools
class CardTypeAttribute < ApplicationRecord
  validates :type, presence: true
  validates :name, uniqueness: true, presence: true
  validates :description, presence: true

  def validate_type
    errors.add(:type, 'Cannot add or create a CardTypeAttribute of Null Type') unless type
  end
end

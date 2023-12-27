class CardTypeAttribute < ApplicationRecord
  validates :type, presence: true
  validates :name, unique: true, presence: true
  validates :descrption, presence: true

  def validate_type
    errors.add(:type, 'Cannot add or create a CardTypeAttribute of Null Type') unless type
  end
end

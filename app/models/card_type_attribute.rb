class CardTypeAttribute < ApplicationRecord
  has_many :card_attributes
  has_many :cards, through: :card_attributes

  validates :type, presence: true
end
